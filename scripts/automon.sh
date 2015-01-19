#!/bin/bash

# Source: https://bbs.archlinux.org/viewtopic.php?id=171655

# Substitutes in the directory names of all detected monitors
export STATUSES=$(eval echo /sys/class/drm/{$(printf "%s" "$(ls /sys/class/drm | grep card0- )"| tr '\n' ',')}/status)


# Discarded loop because 
while false
do
    file="$(inotifywait -e modify,create,delete,open,close,close_write,access $STATUSES | cut -d ' ' -f 1)"
    mode="$(cat $file)"
    monitor=$(echo $fle | sed -r "s/.*card0-([A-Z]+).*([0-9]).*/\1\2/")
    
    if [ "${mode}" = disconnected ]
    then
	/usr/bin/xrandr --auto
	notify-send "$monitor disconnected"
    elif [ "${mode}" = connected ]
    then
	/usr/bin/xrandr --output $monitor --auto --right-of LVDS1
	notify-send "$monitor connected"
    else 
	/usr/bin/xrandr --auto
	notify-send "$monitor is now $mode"
    
    fi
done    

monitor=HDMI1
mode="$(cat /sys/class/drm/card0-HDMI-A-1/status)"

if [ "${mode}" = disconnected ]
then
    /usr/bin/xrandr --auto
    notify-send "$monitor disconnected"
elif [ "${mode}" = connected ]
then
    /usr/bin/xrandr --output $monitor --auto --right-of LVDS1
    notify-send "$monitor connected"
else 
    /usr/bin/xrandr --auto
    notify-send "$monitor is now $mode"

fi
