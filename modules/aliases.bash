# Init global settings for certain bin
if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
fi

# git
alias g='git'
alias gi='git'
alias gti='git'
alias gut='git'
alias got='git'

alias ga='git-aliases.sh'
alias gal='git-aliases.sh'

alias h='history'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ~='cd ~'

alias ls='ls -hF --color'
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'

alias m='more'

# interactive, verbose
alias cp="cp -iv"
alias rm="rm -i"
alias mv="mv -iv"

# ignore case
alias grep="grep -i --color=auto"

alias ips="ifconfig -a | grep -o 'inet addr:\(\([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\)\|[a-fA-F0-9:]\+\)' | sed -e 's/inet addr://'"

alias sa='ssh-add'

# services
alias service='sudo service'

alias nginx-re='service nginx restart'
alias nginx-stop='service nginx stop'

alias memcache-re='service memcached restart'

# repo
alias dotfiles-pull='cd ~/.dotfiles && git fetch origin && git reset --hard origin/master'
