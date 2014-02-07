#!/bin/bash

#
# Helper Functions
#



#
# Install config files for various applications
#
init_config_files() {

	CONFIG=$HOME/.dotfiles/ubuntu/config

	for FILE in $(find $CONFIG -type f -print); do
		FILE=${FILE#$CONFIG/}
		if [ -f $HOME/$FILE ]; then
			echo "Replacing existing $HOME/$FILE"
			rm $HOME/$FILE
		else
			echo "Symlinking $HOME/$FILE"
		fi
		ln -s $CONFIG/$FILE $HOME/$FILE
	done

}


init_config_files

