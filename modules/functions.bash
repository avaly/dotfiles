# Create a new directory and enter it
function mkd() {
    mkdir -p $1 && cd $1
}

function process() {
	ps -ef | grep $1
}

function psgrep() {
	ps aux | grep $1 | grep -v grep
}

function pskill() {
	local pid

	pid=$(ps ax | grep $1 | grep -v grep | awk '{ print $1 }')
	echo -n "killing $1 (process $pid)..."
	kill -9 $pid
	echo "slaughtered."
}

function files() {
	find $1 -type f -print
}

function t() {
    tail -f $1 | perl -pe "s/$2/${BrightRed}$&${ResetColor}/g"
}

# Handy extract function
function extract() {
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   tar xvjf $1     ;;
             *.tar.gz)    tar xvzf $1     ;;
             *.bz2)       bunzip2 $1      ;;
             *.rar)       unrar x $1      ;;
             *.gz)        gunzip $1       ;;
             *.tar)       tar xvf $1      ;;
             *.tbz2)      tar xvjf $1     ;;
             *.tgz)       tar xvzf $1     ;;
             *.zip)       unzip $1        ;;
             *.Z)         uncompress $1   ;;
             *.7z)        7z x $1         ;;
             *)           echo "'$1' cannot be extracted via >extract<" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

# Full dig info
function digg() {
    dig +nocmd $1 any +multiline +noall +answer
}

function dks() {
	docker stop -t 1 $(docker ps -aq)
}

function dkrm() {
	docker ps --filter "status=exited" | grep "$1" | awk '{print $1}' | xargs --no-run-if-empty docker rm
}

function minikube-docker() {
	eval $(minikube docker-env)
}

function clean-boot() {
	local KERNEL_VERSION=$(uname -r | sed -r 's/-[a-z]+//')
	local OLD_KERNEL_VERSIONS=$(dpkg -l linux-{image,headers}-"[0-9]*" | awk '/ii/{print $2}' | grep -ve "$KERNEL_VERSION")
	sudo apt-get purge $OLD_KERNEL_VERSIONS
}

function fsr() {
  grep --line-buffered --color=never -r "" "$1" | fzf
}

# for yarn (yarn add with types)
function yat() {
  yarn add $1

  if ! cat node_modules/$1/package.json | jq -e 'select((.types != null) or .typings != null)' > /dev/null;
  then
    if [[ $1 == @* ]]; then
      TYPE_NAME=$(echo $1 | sed 's/^@//' | sed 's/\//__/')
    else
      TYPE_NAME=$1
    fi
    yarn add -D @types/$TYPE_NAME
  fi
}
