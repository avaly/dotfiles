#
# git functions required in PS1
#
# Adapted from:
# - liquidprompt
# - https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh

# Escape the given strings
# Must be used for all strings injected in PS1 that may comes from remote sources,
# like $PWD, VCS branch names...
function _lp_escape() {
    echo -nE "${1//\\/\\\\}"
}

function _prompt_git_branch() {
  git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return

  local branch
  # Recent versions of Git support the --short option for symbolic-ref, but
  # not 1.7.9 (Ubuntu 12.04)
  if branch="$(git symbolic-ref -q HEAD)"; then
      _lp_escape "${branch#refs/heads/}"
  else
      # In detached head state, use commit instead
      # No escape needed
      git rev-parse --short -q HEAD
  fi
}

function __git_read() {
  local f="$1"
  shift
  test -r "$f" && read "$@" <"$f"
}

function _prompt_git_status() {
  local branch=$(_prompt_git_branch)
  if [[ -z "$branch" ]]; then
    return
  fi

  local git_dir=".git"

  local action=""
  if [ -d "$git_dir/rebase-merge" ]; then
    __git_read "$git_dir/rebase-merge/head-name" rebase_branch
    __git_read "$git_dir/rebase-merge/msgnum" step
    __git_read "$git_dir/rebase-merge/end" total
    if [ -f "$git_dir/rebase-merge/interactive" ]; then
      action="${Magenta} REBASE-i"
    else
      action="${Magenta} REBASE-m"
    fi
  else
    if [ -d "$g/rebase-apply" ]; then
      __git_read "$g/rebase-apply/next" step
      __git_read "$g/rebase-apply/last" total
      if [ -f "$g/rebase-apply/rebasing" ]; then
        action="${Magenta} REBASE"
      elif [ -f "$g/rebase-apply/applying" ]; then
        action="${Magenta} AM"
      else
        action="${Magenta} AM/REBASE"
      fi
    elif [ -f "$g/MERGE_HEAD" ]; then
      action="${Magenta} MERGING"
    elif [ -f "$g/CHERRY_PICK_HEAD" ]; then
      action="${Magenta} CHERRY-PICKING"
    elif [ -f "$g/REVERT_HEAD" ]; then
      action="${Magenta} REVERTING"
    elif [ -f "$g/BISECT_LOG" ]; then
      action="${Magenta} BISECTING"
    fi
  fi

  if [ -n "$step" ] && [ -n "$total" ]; then
    action="${action} ${step}/${total}"
  fi

  git diff --quiet >/dev/null 2>&1
  local diff_result=$?

  git diff --cached --quiet >/dev/null 2>&1
  local diff_cached_result=$?

  local has_staged
  if [[ "$diff_cached_result" -eq "1" ]] ; then
    has_staged=" ${Yellow}staged"
  fi

  local untracked=$(git ls-files --others --exclude-standard --directory \
    --no-empty-directory --error-unmatch -- ':/*' 2>/dev/null)
  local has_untracked=""
  if [[ ! -z "$untracked" ]] ; then
    has_untracked=" ${Yellow}untracked"
  fi

  local stash=$(git stash list 2>/dev/null)
  local has_stash=""
  if [[ ! -z "$has_stash" ]] ; then
    has_stash=" ${BrightYellow}stash"
  fi

  local remote="$(git config --get branch.${branch}.remote 2>/dev/null)"
  # if git has no upstream, use origin
  if [[ -z "$remote" ]]; then
    remote="origin"
  fi
  local remote_branch="$(git config --get branch.${branch}.merge 2>/dev/null)"
  # without any remote branch, use the same name
  if [[ -z "$remote_branch" ]]; then
    remote_branch="$branch"
  else
    remote_branch="${remote_branch#refs/heads/}"
  fi

  local commits=0
  if [[ -n "$remote" && -n "$remote_branch" ]] ; then
    commits=$(git rev-list --no-merges --count \
      ${remote}/${remote_branch}..${branch} 2>/dev/null)
    if [[ -z "$commits" ]] ; then
      commits=0
    fi
  fi

  local has_commit=""
  if [[ "$commits" -gt "0" ]] ; then
    has_commit="${Blue} ${commits} behind remote"
  fi

  local result=""
  if [[ "$diff_result" -eq "1" ]] ; then
    # unstaged changes
    result="${BrightRed}${branch}${has_staged}${has_untracked}${has_commit}${has_stash}${action}"
  else
    if [[ "$diff_cached_result" -eq "1" ]] ; then
      # staged changes
      result="${Magenta}${branch}${has_staged}${has_untracked}${has_commit}${has_stash}${action}"
    else
      # clean
      result="${Cyan}${branch}${has_staged}${has_untracked}${has_commit}${has_stash}${action}"
    fi
  fi

  echo -ne " on ${result}${ResetColor}"
}


custom_prompt() {
  local PSTIME="${BrightBlack}[\$(date +%H:%M:%S)]${ResetColor} "
  local PSHOST="${Magenta}\h${ResetColor}"
  local PSUSER="${BrightBlue}\u${ResetColor}"
  local PSDIR="${Green}\w${ResetColor}"
  local PSGIT="\$(_prompt_git_status)"
  local PSK8="\$(kube_ps1)"

  export PS1="\n${PSTIME}${PSHOST} ${PSUSER} in ${PSDIR}${PSGIT} ${PSK8}\n\\$ "
}

custom_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
  PS1="\[\e]0;\u@\h: \w\a\]$PS1"
  ;;
*)
  ;;
esac
