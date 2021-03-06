#!/bin/bash

mkdir -p /tmp/screenies

FILE="/tmp/screenies/screenie_$(date +'%Y-%m-%d_%H-%M-%S').png"

import $FILE

SERVER=zinc
BASEPATH=/var/www/triazo/files/

scp $FILE $SERVER:$BASEPATH$(basename $FILE) >/dev/null
echo -n "https://triazo.net/files/$(basename $FILE)" | xclip -r -selection "clip board"
echo -n "https://triazo.net/files/$(basename $FILE)" | xclip -r 
notify-send "uploaded https://triazo.net/files/$(basename $FILE)"
