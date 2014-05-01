#!/bin/bash

#
# Helper Functions
#



#
# Install config files for various applications
#
init_config_files() {
	CONFIG=$HOME/.dotfiles/ubuntu/config

	OLDIFS=$IFS
	IFS=$(echo -en "\n\b")

	for FILE in $(find $CONFIG -type f -print); do
		FILE=${FILE#$CONFIG/}
		if [ -h "$HOME/$FILE" ]; then
			echo "Replacing existing symlink $HOME/$FILE"
			unlink "$HOME/$FILE"
		else
			if [ -f "$HOME/$FILE" ]; then
				echo "Replacing existing file $HOME/$FILE"
				rm "$HOME/$FILE"
			else
				echo "Symlinking $HOME/$FILE"
			fi
		fi
		DIR=$(dirname "$HOME/$FILE")
		if [ ! -d "$DIR" ]; then
			echo "Creating directory $DIR"
			mkdir -p "$DIR"
		fi
		ln -s "$CONFIG/$FILE" "$HOME/$FILE"
	done

	IFS=$OLDIFS
}


init_config_files

