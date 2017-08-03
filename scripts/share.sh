#!/bin/sh

FILE=$1
BASEPATH=/var/www/triazo/files/

SERVER=zinc
BASEPATH=/var/www/triazo/files/

scp $FILE $SERVER:$BASEPATH$(basename $FILE) >/dev/null
echo https://triazo.net/files/$(basename $FILE)
