#!/bin/sh

FILE=$1

SERVER=zinc
scp $FILE $SERVER:$BASEPATH$(basename $FILE) >/dev/null
echo https://triazo.net/files/$(basename $FILE)

