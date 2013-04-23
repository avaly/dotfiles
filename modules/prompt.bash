#
# git functions required in PS1
#

# Adapted from liquidprompt

_prompt_git_branch()
{
    local branch="$(git symbolic-ref HEAD 2>/dev/null)"
    if [[ $? -ne 0 || -z "$branch" ]] ; then
        # In detached head state, use commit instead
        branch="$(git rev-parse --short HEAD 2>/dev/null)"
    fi
    [[ $? -ne 0 || -z "$branch" ]] && return
    branch="${branch#refs/heads/}"
    echo $(printf "%q" "$branch")
}

_prompt_git_status()
{
    local branch
    branch=$(_prompt_git_branch)
    if [[ ! -z "$branch" ]] ; then
        local GD
        git diff --quiet >/dev/null 2>&1
        GD=$?

        local GDC
        git diff --cached --quiet >/dev/null 2>&1
        GDC=$?

        local has_staged
        if [[ "$GDC" -eq "1" ]] ; then
            has_staged=" ${CLR_YELLOW}staged"
        fi

        local has_untracked
        has_untracked=$(git status 2>/dev/null | grep '\(# Untracked\)')
        if [[ -z "$has_untracked" ]] ; then
            has_untracked=""
        else
            has_untracked=" ${CLR_YELLOW}untracked"
        fi

        local has_stash
        has_stash=$(git stash list 2>/dev/null)
        if [[ -z "$has_stash" ]] ; then
            has_stash=""
        else
            has_stash=" ${CLR_YELLOW_L}stash"
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
        fi

        local commits
        commits=0
        if [[ -n "$remote" && -n "$remote_branch" ]] ; then
            commits=$(git rev-list --no-merges --count $remote/${remote_branch}..${branch} 2>/dev/null)
            if [[ -z "$commits" ]] ; then
                commits=0
            fi
        fi

        local has_commit
        if [[ "$commits" -gt "0" ]] ; then
            has_commit=" ${CLR_RED}${commits} commit(s) behind"
        fi

        if [[ "$GD" -eq "1" ]] ; then
            local lines_add
            local lines_del
            lines_add=$(git diff --numstat 2>/dev/null | awk 'NF==3 {plus+=$1} END {printf("+%d", plus)}')
            lines_del=$(git diff --numstat 2>/dev/null | awk 'NF==3 {x+=$1; minus+=$2} END {printf("-%d\n", minus)}')

            # unstaged changes
            ret="${CLR_RED_L}${branch} ${CLR_GREEN}${lines_add}${CLR_GREY}:${CLR_RED}${lines_del}${has_staged}${has_untracked}${has_commit}${has_stash}"
        else
            if [[ "$GDC" -eq "1" ]] ; then
                # staged changes
                ret="${CLR_PURPLE}${branch}${has_staged}${has_untracked}${has_commit}${has_stash}"
            else
                # clean
                ret="${CLR_CYAN}${branch}${has_staged}${has_untracked}${has_commit}${has_stash}"
            fi
        fi

        echo -ne " on $ret${CLR_NONE}"
    fi
}


function custom_prompt {
    local PSTIME="${CLR_GREY}[\$(date +%H:%M:%S)]${CLR_NONE} "
    local PSUSER="${CLR_BLUE_L}\u${CLR_NONE}"
    local PSDIR="${CLR_GREEN}\w${CLR_NONE}"
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
