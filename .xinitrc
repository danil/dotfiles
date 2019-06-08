#!/bin/sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

# Custom X session <https://wiki.ubuntu.com/CustomXSession>.

# Make sure this is before the 'exec' command or it won't be sourced
# <https://wiki.archlinux.org/index.php/xprofile#Making_it_compatible_with_xinit>.
[ -f /etc/xprofile ] && source /etc/xprofile
[ -f ~/.xprofile ] && source ~/.xprofile

# <https://wiki.archlinux.org/index.php/xinitrc#Making_a_DE.2FWM_choice>.
# Here Xfce is kept as default.
session=${1:-stumpwm}

case $session in
    dwm)
        [ -f ~/.dwm/dwmrc ] && source ~/.dwm/dwmrc
        dwm_fifo=/tmp/dwm.fifo && rm -f $dwm_fifo && mkfifo $dwm_fifo
        exec dwm
        ;;
    stumpwm)
        exec /home/danil/bin/stumpwm.ros
        ;;
    xfce|xfce4)
        [ -x ~/.xstart ] && ~/.xstart
        exec startxfce4
        ;;
    # No known session, try to run it as command
    *)
        exec $1
        ;;
esac
