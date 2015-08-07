#!/bin/sh

FILE=$1

SERVER=triazo

scp $FILE triazo:/var/www/triazo/files/$(basename $FILE) >/dev/null
echo http://triazo.net/files/$(basename $FILE)
