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
alias fur='git'
alias hoy='git'

alias ga='git-aliases.sh'
alias gal='git-aliases.sh'

alias gr='grunt'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias ~='cd ~'

alias ls='ls -hF'
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'

alias m='more'

alias cp="cp -v"
alias rm="rm -Iv"
alias mv="mv -v"

alias grep="grep -i --color=auto"

# utils
alias ips="ifconfig -a | grep -o 'inet addr:\(\([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\)\|[a-fA-F0-9:]\+\)' | sed -e 's/inet addr://'"
alias sa="ssh-add"
alias big="du -ks * | sort -n"
alias listeners="lsof -i -P | grep LISTEN"
alias cmds="cut -f1 -d' ' ~/.bash_history | sort | uniq -c | sort -nr | head -n 30"

# services
alias service='sudo service'

alias nginx-re='service nginx restart'
alias nginx-stop='service nginx stop'

alias memcache-re='service memcached restart'

# repo
alias dotfiles-pull='cd ~/.dotfiles && git fetch origin && git reset --hard origin/master'
