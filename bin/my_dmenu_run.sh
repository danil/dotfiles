#!/bin/sh
# <http://tools.suckless.org/dmenu/scripts>.

font="Monospace-12"
prompt="$USER@`hostname`"
foreground="white"
background="black"
selected_foreground="black"
selected_background="OrangeRed1"

dmenu_run -fn $font -p $prompt \
    -nf $foreground -nb $background \
    -sf $selected_foreground -sb $selected_background $@
