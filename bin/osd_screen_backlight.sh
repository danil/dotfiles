#! /bin/sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

# <https://wiki.archlinux.org/index.php/Desktop_notifications#Usage_in_programming>.
dunstify --replace=1 "Screen backlight $(echo_screen_backlight.sh)%"
