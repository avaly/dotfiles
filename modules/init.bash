# Mount external drives

if [ $(iwgetid -r) == "avaly" ]; then
	$(sudo mount -l | grep /media/nas)
	NAS_MOUNTED=$?
	echo "NAS_MOUNTED: $NAS_MOUNTED"

	if [ "$NAS_MOUNTED" == "1" ]; then
		sudo mount -a
	fi
fi
