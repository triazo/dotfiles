#!/bin/bash


# Set colors into array for terminal

bgcolor=rgba(90,84,117,1)
fgcolor=rgb(248,248,242)
palette_color_0=rgb(4,3,3)
palette_color_1=rgb(249,38,114)
palette_color_10=rgb(194,255,223)
palette_color_11=rgb(255,234,0)
palette_color_12=rgb(194,255,223)
palette_color_13=rgb(255,184,209)
palette_color_14=rgb(197,163,255)
palette_color_15=rgb(248,248,240)
palette_color_2=rgb(194,255,223)
palette_color_3=rgb(230,192,0)
palette_color_4=rgb(194,255,223)
palette_color_5=rgb(255,184,209)
palette_color_6=rgb(197,163,255)
palette_color_7=rgb(248,248,240)
palette_color_8=rgb(96,144,203)
palette_color_9=rgb(255,133,127)

color_preset=Fairyfloss


for f in $(find $HOME/.config -name "*.dottemplate" | tr '\n' ' ')
do