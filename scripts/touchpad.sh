#!/bin/bash

DEVICE=$(xinput list | grep Touch | cut -d '=' -f 2 | awk '{print $1}')
state=$(xinput list-props $DEVICE | grep "Device Enabled" | awk '{print $4}')

if [[ $state -eq 1 ]]; then
    xinput -disable $DEVICE
    # notify-send "Touchpad disabled"
    ~/scripts/header.py message "Touchpad Disabled"
else
    xinput -enable $DEVICE
    # notify-send "Touchpad enabled"
    ~/scripts/header.py message "Touchpad Enabled"
fi
