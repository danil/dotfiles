#!/bin/sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

# Merge in defaults and keymaps.
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi
if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Make sure this is before the 'exec' command or it won't be sourced
# <https://wiki.archlinux.org/index.php/xprofile#Making_it_compatible_with_xinit>.
[ -f /etc/xprofile ] && source /etc/xprofile
[ -f ~/.xprofile ] && source ~/.xprofile

exec $1
