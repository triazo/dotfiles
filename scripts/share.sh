#!/bin/sh

FILE=$1

SERVER=zinc
BASEPATH=/var/www/triazo/files/

scp $FILE $SERVER:$BASEPATH$(basename $FILE) >/dev/null
echo https://triazo.net/files/$(basename $FILE)
