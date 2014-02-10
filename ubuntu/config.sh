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
		if [ -h $HOME/$FILE ]; then
			echo "Replacing existing symlink $HOME/$FILE"
			unlink $HOME/$FILE
		else
			if [ -f $HOME/$FILE ]; then
				echo "Replacing existing file $HOME/$FILE"
				rm $HOME/$FILE
			else
				echo "Symlinking $HOME/$FILE"
			fi
		fi
		ln -s $CONFIG/$FILE $HOME/$FILE
	done

}


init_config_files

