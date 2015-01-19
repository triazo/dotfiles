#!/bin/bash


if [ "$1" = run ]
then
    while true
    do
	/home/adam/usr/bin/dwm
    done
elif [ "$1" = kill ]
then
    killall dwm_run.sh
else
    echo "Usage: $0 [run|kill]"
fi
