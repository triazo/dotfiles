#!/bin/bash

# SSH-agent starting and collection
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi


mkdir -p /tmp/screenies

FILE="/tmp/screenies/screenie_$(date +'%Y-%m-%d_%H-%M-%S').png"

import $FILE

SERVER=zinc
BASEPATH=/var/www/triazo/files/

echo -n "https://triazo.net/files/$(basename $FILE)" | xclip -r -selection "clip board"
echo -n "https://triazo.net/files/$(basename $FILE)" | xclip -r
scp $FILE $SERVER:$BASEPATH$(basename $FILE)
echo  "https://triazo.net/files/$(basename $FILE)"
notify-send "uploaded https://triazo.net/files/$(basename $FILE)"
