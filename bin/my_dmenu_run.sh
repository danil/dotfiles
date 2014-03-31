#!/bin/sh
# <http://tools.suckless.org/dmenu/scripts>.

FN="Monospace-12"
P="$USER@`hostname`"
NF="white"
NB="black"
SF="black"
SB="OrangeRed1"

dmenu_run -fn $FN -nf $NF -nb $NB -sf $SF -sb $SB -p $P $@
