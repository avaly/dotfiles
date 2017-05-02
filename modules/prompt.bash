#
# git functions required in PS1
#
# Adapted from:
# - liquidprompt
# - https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh

_prompt_git_branch()
{
  local branch="$(git symbolic-ref HEAD 2>/dev/null)"
  if [[ $? -ne 0 || -z "$branch" ]] ; then
    # In detached head state, use describe instead
    branch="$(git describe HEAD 2>/dev/null)"
  fi
  [[ $? -ne 0 || -z "$branch" ]] && return
  branch="${branch#refs/heads/}"
  echo $(printf "%q" "$branch")
}

_prompt_git_status()
{
  local branch
  branch=$(_prompt_git_branch)
  if [[ -z "$branch" ]] ; then
    return
  fi

  local GD
  git diff --quiet >/dev/null 2>&1
  GD=$?

  local GDC
  git diff --cached --quiet >/dev/null 2>&1
  GDC=$?

  local has_staged
  if [[ "$GDC" -eq "1" ]] ; then
    has_staged=" ${Yellow}staged"
  fi

  local has_untracked
  has_untracked=$(git ls-files --others --exclude-standard --directory --no-empty-directory --error-unmatch -- ':/*' 2>/dev/null)
  if [[ -z "$has_untracked" ]] ; then
    has_untracked=""
  else
    has_untracked=" ${Yellow}untracked"
  fi

  local has_stash
  has_stash=$(git stash list 2>/dev/null)
  if [[ -z "$has_stash" ]] ; then
    has_stash=""
  else
    has_stash=" ${BrightYellow}stash"
  fi

  local remote
  remote="$(git config --get branch.${branch}.remote 2>/dev/null)"
  # if git has no upstream, use origin
  if [[ -z "$remote" ]]; then
    remote="origin"
  fi
  local remote_branch
  remote_branch="$(git config --get branch.${branch}.merge 2>/dev/null)"
  # without any remote branch, use the same name
  if [[ -z "$remote_branch" ]]; then
    remote_branch="$branch"
  else
    remote_branch="${remote_branch#refs/heads/}"
  fi

  local commits
  commits=0
  if [[ -n "$remote" && -n "$remote_branch" ]] ; then
    commits=$(git rev-list --no-merges --count ${remote}/${remote_branch}..${branch} 2>/dev/null)
    if [[ -z "$commits" ]] ; then
      commits=0
    fi
  fi

  local has_commit
  if [[ "$commits" -gt "0" ]] ; then
    has_commit="${Blue} ${commits} behind remote"
  fi

  local result
  if [[ "$GD" -eq "1" ]] ; then
    # unstaged changes
    result="${BrightRed}${branch}${has_staged}${has_untracked}${has_commit}${has_stash}"
  else
    if [[ "$GDC" -eq "1" ]] ; then
      # staged changes
      result="${Magenta}${branch}${has_staged}${has_untracked}${has_commit}${has_stash}"
    else
      # clean
      result="${Cyan}${branch}${has_staged}${has_untracked}${has_commit}${has_stash}"
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

  export PS1="\n${PSTIME}${PSHOST} ${PSUSER} in ${PSDIR}${PSGIT}\n\\$ "
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
