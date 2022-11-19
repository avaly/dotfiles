#
# Setup check
#

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

THIS_COMPLETION=~/.dotfiles/completion
THIS_MODULES=~/.dotfiles/modules
LOCAL_MODULES=~/.dotfiles.local

function load_modules() {
	# Terminal session without X
	SHARED_MODULES=(
		'aliases.bash'
		'setup.bash'
		'functions.bash'
	)

	# Terminal session inside X
	NONLOGIN_MODULES=(
		'colors.bash'
		'kubernetes.bash'
		'prompt.bash'
		'fzf.bash'
		'init.bash'
	)

	for MODULE in ${SHARED_MODULES[@]}; do
		[ -f $1/$MODULE ] && source $1/$MODULE
	done

	# Text only sessions, but not SSH sessions
	if [[ ! -z "$BASH_NONLOGIN" || $(tty) == "$SSH_TTY" ]]; then
		for MODULE in ${NONLOGIN_MODULES[@]}; do
			[ -f $1/$MODULE ] && source $1/$MODULE
		done
	fi
}

function load_completion() {
	COMPLETION_MODULES=(
		'aliases.bash'
		'git.bash'
	)

	for MODULE in ${COMPLETION_MODULES[@]}; do
		[ -f $THIS_COMPLETION/$MODULE ] && source $THIS_COMPLETION/$MODULE
	done
}

# Configure from local modules
if [[ -f $LOCAL_MODULES/configure.bash ]]; then
	source $LOCAL_MODULES/configure.bash
fi

# Default modules
load_modules $THIS_MODULES
load_completion

# Local modules

if [[ -d $LOCAL_MODULES ]]; then
	load_modules $LOCAL_MODULES
fi
