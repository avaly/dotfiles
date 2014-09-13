#!/bin/bash

#
# Installs .dotfiles
#

# Check if .dotfiles are already installed

COUNT=$(grep -c 'dotfiles' ~/.bash_profile 2> /dev/null)

if [[ ! -z $COUNT ]] && [[ $COUNT -gt 0 ]]; then
	echo ".dotfiles are already installed!"
	exit
fi


# Continue with the install

echo "Installing .dotfiles..."

echo "source ~/.dotfiles/index-login.bash" > ~/.bash_profile
echo "source ~/.dotfiles/index-nonlogin.bash" > ~/.bashrc

mkdir ~/bin 2> /dev/null
cp -n ~/.dotfiles/bin/* ~/bin
chmod a+x ~/bin/*

mkdir ~/.dotfiles.local 2> /dev/null
cp -n ~/.dotfiles/local/* ~/.dotfiles.local

ln -s -f ~/.dotfiles/.gitconfig ~/.gitconfig

# vim
ln -s -f ~/.dotfiles/.vimrc ~/.vimrc
mkdir ~/.vim 2> /dev/null
# vim NERDTree plugin
cd ~/.vim
wget https://github.com/scrooloose/nerdtree/archive/4.2.0.tar.gz
tar xzf 4.2.0.tar.gz
cp -R nerdtree-4.2.0/* .
rm -rf nerdtree-4.2.0/
rm 4.2.0.tar.gz

echo "Done!"
