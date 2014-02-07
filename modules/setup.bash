#
# Bash History
#

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL="ignoredups:ignorespace"

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=100000
export HISTFILESIZE=100000

# Make some commands not show up in history
export HISTIGNORE="ls:ll:cd:cd -:..:pwd:g st:g ls:g d:exit:date:* --help"



#
# Editor
#
export EDITOR="vim"

#
# Terminal
#
export PATH="./node_modules/.bin:./../node_modules/.bin:$HOME/bin:$PATH"

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
shopt -s autocd 2> /dev/null
# * Recursive globbing, e.g. `echo **/*.txt`
shopt -s globstar 2> /dev/null


# Use custom less colors for man pages
# (http://www.gnu.org/software/termutils/manual/termutils-2.0/html_chapter/tput_1.html)
export LESS_TERMCAP_md=$'\E[1;32m' # begin bold mode
export LESS_TERMCAP_me=$'\E[0m' # end bold mode


# enable programmable completion features
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
	. /etc/bash_completion
fi


# Terminal color codes
# Source: http://www.pixelbeat.org/docs/terminal_colours/
# Source: http://www.developerzen.com/2011/01/10/show-the-current-git-branch-in-your-command-prompt/
# These are wrapped in non-printing characters for the prompt, however when used in echo directly
# we need to use \001 and \002 instead of \[ and \].

CLR_BLACK="\001\033[0;30m\002"
CLR_GREY="\001\033[1;30m\002"
CLR_RED="\001\033[0;31m\002"
CLR_RED_L="\001\033[1;31m\002"
CLR_GREEN="\001\033[0;32m\002"
CLR_GREEN_L="\001\033[1;32m\002"
CLR_YELLOW="\001\033[0;33m\002"
CLR_YELLOW_L="\001\033[1;33m\002"
CLR_BLUE="\001\033[0;34m\002"
CLR_BLUE_L="\001\033[1;34m\002"
CLR_PURPLE="\001\033[0;35m\002"
CLR_PURPLE_L="\001\033[1;35m\002"
CLR_CYAN="\001\033[0;36m\002"
CLR_CYAN_L="\001\033[1;36m\002"
CLR_GREY_L="\001\033[0;37m\002"
CLR_WHITE="\001\033[1;37m\002"
CLR_NONE="\001\033[0m\002"

P_CLR_BLACK="\[\033[0;30m\]"
P_CLR_GREY="\[\033[1;30m\]"
P_CLR_RED="\[\033[0;31m\]"
P_CLR_RED_L="\[\033[1;31m\]"
P_CLR_GREEN="\[\033[0;32m\]"
P_CLR_GREEN_L="\[\033[1;32m\]"
P_CLR_YELLOW="\[\033[0;33m\]"
P_CLR_YELLOW_L="\[\033[1;33m\]"
P_CLR_BLUE="\[\033[0;34m\]"
P_CLR_BLUE_L="\[\033[1;34m\]"
P_CLR_PURPLE="\[\033[0;35m\]"
P_CLR_PURPLE_L="\[\033[1;35m\]"
P_CLR_CYAN="\[\033[0;36m\]"
P_CLR_CYAN_L="\[\033[1;36m\]"
P_CLR_GREY_L="\[\033[0;37m\]"
P_CLR_WHITE="\[\033[1;37m\]"
P_CLR_NONE="\[\033[0m\]"
