#!/bin/bash

usage() {
	echo "usage: deploy-img-SD -i image -d dest"
	exit
}

strImageFilename=
strDiskDest=

while [ "$1" != "" ]; do
    case $1 in
        -i | --image)   shift
                        strImageFilename=$1
                        ;;

        -d | --dest)	shift
                        strDiskDest=$1
                        ;;

        -h | --help)    usage
                        ;;

        * )             usage                       
                        ;;

    esac
    shift
done

if [ -z "$strImageFilename" ] || [ -z "$strDiskDest" ]
then
	usage
fi

sudo echo "Copying image"
exec sudo dd if=$strImageFilename | pv | sudo dd of=$strDiskDest bs=4096; sync
