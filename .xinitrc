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

# Turn off bell.
xset b off

# Set the keyboard auto repeat parameters.
xset r rate 300 30

# xbindkeys.
# The first line makes sure any running xbindkeys is killed. The
# second starts and backgrounds xscreensaver.
killall xbindkeys 2>/dev/null
xbindkeys

# # Screensaver.
# # xlock and xautolock
# # <http://onyon.net/index.php/2006-11-26_22.40.07_irssiandXawareautoaway>.
# xautolock -exit
# killall xautolock 2>/dev/null
# killall xlock 2>/dev/null
# xautolock -time 10 -locker "xlock -mode deco -lockdelay 60" &

# Xscreensaver
# <http://en.wikibooks.org/wiki/Using_Ratpoison/Example_Config>,
# <http://en.wikipedia.org/wiki/User:Gwern/.stumpwmrc>.
# I use Xscreensaver as a screensaver. The first line makes sure any
# running Xscreensaver is killed.  The second run regardless of the
# success of the first & starts a background Xscreensaver daemon.
xscreensaver-command -exit
killall xscreensaver 2>/dev/null
xscreensaver -nosplash &

urxvtd --fork --quiet
feh --bg-center ~/local/share/backgrounds/gentoo-znurt-larry-abducted-1440x900.png &

# <https://wiki.archlinux.org/index.php/Udiskie#Installation>.
udiskie &

# The following variable defines the session which is started if the
# user doesn't explicitly select a session
# <http://svn.berlios.de/svnroot/repos/slim/trunk/xinitrc.sample>.
# Compiz 0.8.
DEFAULT_SESSION=compiz-manager
# # Compiz 0.9.
# DEFAULT_SESSION=compiz

# * Messages for package gnome-base/gnome-menus-2.30.5:
# * Due to bug #256614, you might lose icons in applications menus.
# * If you use a login manager, please re-select your session.
# * If you use startx and have no .xinitrc, just export XSESSION=Gnome.
# * If you use startx and have .xinitrc, export XDG_MENU_PREFIX=gnome-

# Slim
# <http://en.gentoo-wiki.com/wiki/SLiM#Preparing_for_multiple_sessions>.
case $1 in
    compiz)
        # Running several applications from ~/.xinitrc
        # <https://wiki.archlinux.org/index.php/ConsoleKit#Running_several_applications_from_.7E.2F.xinitrc>.
        ~/.xstart
        # Since Slim 1.3.3 NO longer include ck-launch-session in .xinitrc
        # <https://wiki.archlinux.org/index.php/SLiM#Single_environments>.
        exec bash -c "dbus-launch $DEFAULT_SESSION"
        ;;
    fluxbox)
        exec startfluxbox
        ;;
    *)
        ~/.xstart
        exec dbus-launch $DEFAULT_SESSION
        ;;
esac
