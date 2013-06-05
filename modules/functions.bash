# Create a new directory and enter it
mkd()
{
    mkdir -p $1 && cd $1
}

process()
{
	ps -ef | grep $1
}

psgrep()
{
	ps aux | grep $1 | grep -v grep
}

pskill()
{
	local pid

	pid=$(ps ax | grep $1 | grep -v grep | awk '{ print $1 }')
	echo -n "killing $1 (process $pid)..."
	kill -9 $pid
	echo "slaughtered."
}

files()
{
	find $1 -type f -print
}

ff()
{
	find . -name $1 -print
}

t()
{
    tail -f $1 | perl -pe "s/$2/${CLR_PURPLE_L}$&${CLR_NONE}/g"
}

# Handy extract function
extract()
{
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
digg()
{
    dig +nocmd $1 any +multiline +noall +answer
}
