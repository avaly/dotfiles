#
# git functions required in PS1
#
function parse_git_dirty {
    echo -n $(git status 2>/dev/null | awk -v out=$1 -v std="dirty" '{ if ($0=="# Changes to be committed:") std = "uncommited"; last=$0 } END{ if(last!="" && last!="nothing to commit (working directory clean)" && last!="nothing to commit, working directory clean") { if(out!="") print out; else print std } }')
}

function parse_git_branch {
    local branch=$(git branch --no-color 2>/dev/null| sed -n '/^\*/s/^\* //p')
    if [[ $branch != "" ]]
    then
        echo -n "$1$branch$2";
    fi
}

function parse_git_remote {
    echo -n $(git status 2>/dev/null | awk -v out=$1 '/# Your branch is / { if(out=="") print $5; else print out }')
}


function bash_prompt_color {
    local PSTIME="${CLR_GREY}\$(date +%H:%M)${CLR_NONE} "
    local PSHOST="${CLR_PURPLE}\h${CLR_NONE}"
    local PSUSER="${CLR_BLUE_L}\u${CLR_NONE}"
    local PSDIR="${CLR_GREEN}\w${CLR_NONE}"
    local PSGIT="\$(parse_git_branch \" on ${P_CLR_CYAN}\")\$(parse_git_dirty \"${P_CLR_RED}:\")\$(parse_git_dirty)${P_CLR_NONE}"

    export PS1="\n${PSTIME}${PSHOST} ${PSUSER} in ${PSDIR}${PSGIT}\n\\$ "
}


bash_prompt_color


# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac
