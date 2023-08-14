#!/bin/bash
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

# Custom X session <https://wiki.ubuntu.com/CustomXSession>.

# Make sure this is before the 'exec' command or it won't be sourced
# <https://wiki.archlinux.org/index.php/xprofile#Making_it_compatible_with_xinit>.
[ -f /etc/xprofile ] && source /etc/xprofile
[ -f ~/.xprofile ] && source ~/.xprofile

# <https://wiki.archlinux.org/index.php/xinitrc#Making_a_DE.2FWM_choice>.
# Here Xfce is kept as default.
session=${1:-i3}

case $session in
    i3)
        exec /usr/bin/i3
        ;;
    dwm)
        [ -f ~/.dwm/dwmrc ] && source ~/.dwm/dwmrc
        f=/tmp/dwm.fifo && rm -f $f && mkfifo $f
        # exec ck-launch-session dbus-launch --sh-syntax --exit-with-session /home/danil/.local/usr/local/bin/dwm
        # exec dbus-launch --exit-with-session /home/danil/.local/usr/local/bin/dwm
        # exec /home/danil/.local/usr/local/bin/dwm
        exec ~/.local/usr/local/bin/dwm
        ;;
    stump|stumpwm)
        exec ~/bin/stumpwm
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
