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

cp -f ~/.bash_profile ~/.bash_profile.bak
cp -f ~/.bashrc ~/.bashrc.bak

echo "source ~/.dotfiles/index-login.bash" > ~/.bash_profile
echo "source ~/.dotfiles/index-nonlogin.bash" > ~/.bashrc

mkdir ~/bin 2> /dev/null
for FILE in ~/.dotfiles/bin/*
do
	NAME=$(basename $FILE)
	ln -s -f $FILE ~/bin/$NAME
done

mkdir ~/.dotfiles.local 2> /dev/null
cp -n ~/.dotfiles/local/* ~/.dotfiles.local

# git
ln -s -f ~/.dotfiles/.gitconfig ~/.gitconfig
# git-extras
$(which git-extras)
if [[ $? -ne 0 ]]; then
	git clone --depth 1 https://github.com/tj/git-extras.git /tmp/git-extras
	cd /tmp/git-extras
	rm bin/git-undo
	rm man/git-undo*
	sudo make install
fi

# z
mkdir ~/apps
git clone --depth 1 git@github.com:rupa/z.git ~/apps/z

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
