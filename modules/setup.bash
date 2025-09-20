#
# Bash History
#

# http://mywiki.wooledge.org/BashFAQ/088
# append to the history file, don't overwrite it
shopt -s histappend
export PROMPT_COMMAND="history -a"

# See `man bash` for more details:
# don't put duplicate lines in the history.
export HISTCONTROL="ignoredups:ignorespace"
export HISTTIMEFORMAT="%y-%m-%d %T "
# Numeric values less than zero result in every command being saved on the history list (there is no limit).
export HISTSIZE=-1
# Non-numeric values and numeric values less than zero inhibit truncation.
export HISTFILESIZE=-1

# Make some commands not show up in history
export HISTIGNORE="ls:ll:cd:cd -:..:pwd:g ap:g st:g l:g d:g fix:g fixm:g fixms:g amend:g ps:g psf:gpr:exit:date:yarn:pn i"

#
# Editor
#
export EDITOR="vim"

#
# Terminal
#
export PATH="$PATH:/usr/local/bin:./node_modules/.bin:./bin:$HOME/bin:$HOME/.local/bin:$HOME/apps:$HOME/apps/git-fuzzy/bin"

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
