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

exec $1
