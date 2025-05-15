#!/bin/bash

sed -i -e 's/dvorak,/,dvorak/g' -e t -e 's/,dvorak/dvorak,/g' ~/.config/hypr/hyprland.conf
