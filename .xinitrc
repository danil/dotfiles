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

# The following variable defines the session which is started if the
# user doesn't explicitly select a session
# <http://svn.berlios.de/svnroot/repos/slim/trunk/xinitrc.sample>.
# # Compiz 0.8.
# DEFAULT_SESSION=compiz-manager
# # Compiz 0.9.
# DEFAULT_SESSION=compiz
DEFAULT_SESSION=startxfce4

# * Messages for package gnome-base/gnome-menus-2.30.5:
# * Due to bug #256614, you might lose icons in applications menus.
# * If you use a login manager, please re-select your session.
# * If you use startx and have no .xinitrc, just export XSESSION=Gnome.
# * If you use startx and have .xinitrc, export XDG_MENU_PREFIX=gnome-

# Slim
# <http://en.gentoo-wiki.com/wiki/SLiM#Preparing_for_multiple_sessions>.
case $1 in
    xfce)
        exec $DEFAULT_SESSION
        ;;
    compiz)
        # Running several applications from ~/.xinitrc
        # <https://wiki.archlinux.org/index.php/ConsoleKit#Running_several_applications_from_.7E.2F.xinitrc>.
        ~/.xstart_compiz
        # Since Slim 1.3.3 NO longer include ck-launch-session in .xinitrc
        # <https://wiki.archlinux.org/index.php/SLiM#Single_environments>.
        # exec dbus-launch compiz-manager
        exec bash -c "dbus-launch compiz-manager"
        ;;
    fluxbox)
        exec startfluxbox
        ;;
    i3)
        exec i3
        ;;
    *)
        exec dbus-launch $DEFAULT_SESSION
        ;;
esac
