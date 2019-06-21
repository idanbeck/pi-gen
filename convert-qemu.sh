#!/bin/bash

usage() {
	echo "usage: convert-qemu -i image -o output"
	exit
}

strImageFilename=
strOutputFilename=

while [ "$1" != "" ]; do
	case $1 in
		-i | --image)	shift
						strImageFilename=$1
						;;
		
		-o | --output)	shift
						strOutputFilename=$1
						;;

		-h | --help)	usage
						;;

		* )				usage						
						;;

	esac
	shift
done

if [ -z "$strImageFilename" ] || [ -z "$strOutputFilename" ]
then 
	usage
fi



# Convert 
qemu-img convert -f raw -O qcow2 $strImageFilename $strOutputFilename

if [ ! -f $strOutputFilename ] 
then
	echo "$strOutputFilename not found... exiting"
	exit
fi

# Resize 
qemu-img resize $strOutputFilename +1G

echo "Successfully converted and resized $strOutputFilename"

qemu-img info $strOutputFilename

