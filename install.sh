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
ln -s ~/.dotfiles/.inputrc ~/.inputrc

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

mkdir ~/apps

# z
git clone --depth 1 git@github.com:rupa/z.git ~/apps/z

# github cli
wget -O gh.deb https://github.com/cli/cli/releases/download/v2.57.0/gh_2.57.0_linux_amd64.deb
sudo dpkg -i ./gh.deb
rm ./gh.deb

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/apps/fzf
~/apps/fzf/install --no-key-bindings --no-completion --no-update-rc

# git-fuzzy
git clone --depth 1 https://github.com/bigH/git-fuzzy.git ~/apps/git-fuzzy

# delta
wget -O ./delta.deb https://github.com/dandavison/delta/releases/download/0.0.15/git-delta-musl_0.0.15_amd64.deb
sudo dpkg -i ./delta.deb
rm ./delta.deb

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
