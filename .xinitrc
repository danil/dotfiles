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

# # Slim
# # <http://en.gentoo-wiki.com/wiki/SLiM#Preparing_for_multiple_sessions>.
# case $1 in
#     compiz)
#         # Running several applications from ~/.xinitrc
#         # <https://wiki.archlinux.org/index.php/ConsoleKit#Running_several_applications_from_.7E.2F.xinitrc>.
#         ~/.xstart_compiz
#         # Since Slim 1.3.3 NO longer include ck-launch-session in .xinitrc
#         # <https://wiki.archlinux.org/index.php/SLiM#Single_environments>.
#         # exec dbus-launch compiz-manager
#         exec bash -c "dbus-launch compiz-manager"
#         ;;
#     *)
#         exec dbus-launch $DEFAULT_SESSION
#         ;;
# esac

exec $1
