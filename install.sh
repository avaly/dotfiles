#
# Installs .dotfiles
#

# Check if .dotfiles are already installed

COUNT=$(grep -c 'dotfiles' ~/bash_profile 2> /dev/null)

if [[ ! -z $COUNT ]] && [[ $COUNT -gt 0 ]]; then
	echo ".dotfiles are already installed!"
	exit
fi


# Continue with the install

echo "Installing .dotfiles..."

echo "source ~/.dotfiles/index-login.bash" > ~/.bash_profile
echo "source ~/.dotfiles/index-nonlogin.bash" > ~/.bashrc

ln -s -f ~/.dotfiles/.gitconfig ~/.gitconfig

mkdir ~/bin 2> /dev/null
cp -n ~/.dotfiles/bin/* ~/bin
chmod a+x ~/bin/*

mkdir ~/.dotfiles.local 2> /dev/null
cp -n ~/.dotfiles/local/* ~/.dotfiles.local

echo "Done!"
