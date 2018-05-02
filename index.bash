#
# Setup check
#

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

function load_modules {
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
		'git-completion.bash'
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

# Local modules
MODULE_DIR=~/.dotfiles.local

if [[ -d $MODULE_DIR ]]; then
	load_modules $MODULE_DIR
fi

# Default modules
MODULE_DIR=~/.dotfiles/modules

load_modules $MODULE_DIR
