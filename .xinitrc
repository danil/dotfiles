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

function startup_applications {
    dbus-launch nautilus --no-default-window &
    if [[ `hostname -s` == "leela" ]]; then
        argyll-dispwin ~/t400s_082409.icm &
    fi
    tint2 &
    # parcellite &
    dbus-launch volumeicon &
    dbus-launch gnome-power-manager &
    dbus-launch wicd-gtk --tray &
    # conky -c ~/.conky/conkyrc_calendar &
    # conky -c ~/.conky/conkyrc_top &
    dbus-launch avant-window-navigator &
    dbus-launch empathy &
    # stardict &
    # screenletsd --cli run ClockRing &
    # screenletsd --cli run ClearCalendar &
    # screenletsd --cli run ClearWeather &
    # screenletsd --cli run Calc &

    # tint2 Double system tray icons
    # <http://code.google.com/p/tint2/issues/detail?id=343#hc8>,
    # <https://bbs.archlinux.org/viewtopic.php?id=111712>.
    killall -SIGUSR1 tint2
}

# The following variable defines the session which is started if the
# user doesn't explicitly select a session
# <http://svn.berlios.de/svnroot/repos/slim/trunk/xinitrc.sample>.
DEFAULT_SESSION=compiz-manager

# Slim
# <http://en.gentoo-wiki.com/wiki/SLiM#Preparing_for_multiple_sessions>.
case $1 in
    xmonad)
        exec xmonad
        ;;
    stumpwm)
        exec stumpwm
        ;;
    ratpoison)
        exec ratpoison
        ;;
    fluxbox)
        exec startfluxbox
        ;;
    compiz)
        startup_applications
        exec $DEFAULT_SESSION
        ;;
    *)
        startup_applications
        exec $DEFAULT_SESSION
        ;;
esac
