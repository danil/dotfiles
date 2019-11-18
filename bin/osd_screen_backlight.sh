#! /bin/bash
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

source osd_progress_bar.sh

percentage=$(echo_screen_backlight.sh)

# ☼ <https://wiki.archlinux.org/index.php/Desktop_notifications#Usage_in_programming>.
if pgrep -x "xfce4-notifyd" > /dev/null
then
    killall xfce4-notifyd
fi

/usr/lib/x86_64-linux-gnu/xfce4/notifyd/xfce4-notifyd &
notify-send --urgency=low "☀ $(printf '%3s' ${percentage})%"
