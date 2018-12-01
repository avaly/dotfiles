#!/bin/bash
#
# Uninstalls .dotfiles
#

if [[ -f ~/.bash_profile.bak ]]; then
	cp -f ~/.bash_profile.back ~./bash_profile
else
	rm ~./bash_profile
fi

if [[ -f ~/.bashrc.bak ]]; then
	cp -f ~/.bashrc.back ~./bashrc
else
	rm ~./bashrc
fi

echo "Done!"
