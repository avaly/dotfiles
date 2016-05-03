# git
alias g="git"
alias gi="git"
alias gti="git"
alias gut="git"
alias got="git"
alias fur="git"
alias hoy="git"

alias ga="git-aliases"
alias gal="git-aliases"

# mercurial
alias h="hg"
alias ham="hg amend"
alias hdiff="hg diff"
alias hdif="hg diff"

# node
alias gr="grunt"
alias nr="npm run"

# fs
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias ~="cd ~"

alias ls="ls -hF --color=auto"
alias ll="ls -la --color=auto"
alias la="ls -A --color=auto"
alias l="ls -CF --color=auto"

alias m="more"

alias cp="cp -v"
alias rm="rm -Iv"
alias mv="mv -v"

alias grep="grep -i --color=auto"

# utils
alias ips="ifconfig -a | grep -o 'inet addr:\(\([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\)\|[a-fA-F0-9:]\+\)' | sed -e 's/inet addr://'"
alias big="du -ks * | sort -n"
alias listen="sudo netstat -ntlp"
alias conns="netstat -ntap | grep ESTABLISHED"
alias cmds="cut -f1 -d' ' ~/.bash_history | sort | uniq -c | sort -nr | head -n 30"
alias memcache-clear="echo 'flush_all' | nc localhost 11211"

# http
alias hosts="cat /etc/hosts"
alias hoste="sudo vim /etc/hosts"
alias sniff="sudo ngrep -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""
alias traffic="sudo jnettop -i eth0"

# ssh
alias sshe="vim ~/.ssh/config"

# services
alias service="sudo service"

alias nginx-re="service nginx restart"
alias apache-re="service apache2 restart"

alias vu="vagrant up"
alias vh="vagrant halt"
alias vs="vagrant ssh"

alias dk="docker"
alias dkc="docker-compose"

# apt
alias apti="sudo apt-get install"
alias aptr="sudo apt-get remove"
alias apts="sudo aptitude search"
alias aptsh="sudo aptitude show"
alias aptup="sudo apt-get update"
alias aptug="sduo apt-get upgrade"

# desktop
alias update-fonts="sudo fc-cache -f -v"
alias open="xdg-open"

# repo
alias dotfiles-pull="cd ~/.dotfiles && git fetch origin && git reset --hard origin/master"

