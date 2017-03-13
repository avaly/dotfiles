# Mount external drives

if [[ $(iwgetid -r) == "avaly" ]]; then
	$(sudo mount -l | grep /media/nas > /dev/null 2>&1)
	NAS_MOUNTED=$?

	if [[ "$NAS_MOUNTED" == "1" ]]; then
		sudo mount -a
	fi
fi

# z
source ~/apps/z/z.sh

