#!/bin/bash
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.
# <https://wiki.archlinux.org/index.php/I3#Shutdown.2C_reboot.2C_lock_screen>.
# xset dpms force off && slock
i3lock --ignore-empty-password --color=000000 || exit 1
xset dpms force off || exit 1
exit 0
