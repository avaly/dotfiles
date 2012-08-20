#
# Setup check
#

# If not running interactively, don't do anything
[ -z "$PS1" ] && return


#
# Modules to include
#
MODULES=(
	'aliases.bash'
	'setup.bash'
	'functions.bash'
	'prompt.bash'
)

function _load_modules {
	for MODULE in ${MODULES[@]}; do
		[ -f $1/$MODULE ] && source $1/$MODULE
	done
}

# Default modules
MODULE_DIR=~/.dotfiles/modules

_load_modules $MODULE_DIR

# Local modules
MODULE_DIR=~/.dotfiles.local

if [[ -d $MODULE_DIR ]]; then
	_load_modules $MODULE_DIR
fi