# Configure
# ---------
export FZF_DEFAULT_COMMAND="fd --type file --hidden --color=always"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="command find -L . -mindepth 1 \
  \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' -o -name node_modules \\) -prune \
  -o -type d -print 2> /dev/null | cut -b3-"
export FZF_COMPLETION_TRIGGER='~~'
export FZF_DEFAULT_OPTS='--no-height --no-reverse --height 80%'

# Setup fzf
# ---------
if [[ ! "$PATH" == */apps/fzf/bin* ]]; then
  export PATH="$PATH:~/apps/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source ~/apps/fzf/shell/completion.bash 2> /dev/null

# Key bindings
# ------------
source ~/apps/fzf/shell/key-bindings.bash


# Custom
# ---------
for FZF_MODULE in ~/.dotfiles/modules/fzf/*.bash; do
  source $FZF_MODULE
done
