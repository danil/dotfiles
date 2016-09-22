#! /bin/sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.
# <https://wiki.archlinux.org/index.php/I3#Shutdown.2C_reboot.2C_lock_screen>.
# xset dpms force off && slock
i3lock --ignore-empty-password --dpms --inactivity-timeout=10 --color=000000
killall dunst &> /dev/null
