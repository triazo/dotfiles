#!/bin/sh

FILE=$1

SERVER=zinc

scp $FILE $SERVER:/var/www/triazo/files/$(basename $FILE) >/dev/null
echo http://triazo.net/files/$(basename $FILE)
