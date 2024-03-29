#
# Bash History
#

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL="ignoredups:ignorespace"
export HISTTIMEFORMAT="%y-%m-%d %T "

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=1000000
export HISTFILESIZE=1000000

# Make some commands not show up in history
export HISTIGNORE="ls:ll:cd:cd -:..:pwd:g ap:g st:g l:g d:g fix:g fixm:g fixms:g ps:g psf:gpr:exit:date"



#
# Editor
#
export EDITOR="vim"

#
# Terminal
#
export PATH="$PATH:/usr/local/bin:./node_modules/.bin:./bin:$HOME/bin:$HOME/.local/bin:$HOME/.yarn/bin:$HOME/.volta/bin:$HOME/apps:$HOME/apps/git-fuzzy/bin"

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
	source /etc/bash_completion
fi
