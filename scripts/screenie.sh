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

echo $XDG_SESSION_TYPE

if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
	grim -g "$(slurp)" $FILE
else
	import $FILE
fi

chmod a+r $FILE

SERVER=zinc
BASEPATH=/var/www/triazo/files/
URL=https://triazo.net/files/$(basename $FILE)

echo -n "${URL}" | xclip -r -selection "clip board"
echo -n "${URL}" | xclip -r
echo -n "${URL}" | /usr/bin/wl-copy
echo -n "${URL}" | /usr/bin/wl-copy -p
scp $FILE $SERVER:$BASEPATH$(basename $FILE)
echo  "https://triazo.net/files/$(basename $FILE)"
notify-send "uploaded https://triazo.net/files/$(basename $FILE)"
