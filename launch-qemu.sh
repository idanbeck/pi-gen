#!/bin/bash

usage() {
	echo "usage: launch-qemu -i image"
	exit
}

strImageFilename=
strKernelFilename=kernel-qemu-4.4.34-jessie

while [ "$1" != "" ]; do
	case $1 in
		-i | --image)		shift
							strImageFilename=$1
							;;
		
		-h | --help)		usage
							;;
		
		* )					usage
							;;
	esac
	shift
done

if [ ! -f $strImageFilename ] 
then
	echo "$strImageFilename not found"
	usage
fi

if [ ! -f $strKernelFilename ] 
then
	echo "$strKernelFilename kernel not found"
	usage
fi

echo "launching qemu with image $strImageFilename"
qemu-img info $strImageFilename

echo "kernel $strKernelFilename"
qemu-img info $strKernelFilename

# execute QEMU
exec sudo qemu-system-arm -kernel $strKernelFilename -append "root=/dev/sda2 panic=1 rootfstype=ext4 rw" -hda $strImageFilename -cpu arm1176 -m 256 -M versatilepb -no-reboot -serial stdio -net user,hostfwd=tcp::5022-:22 -net nic
