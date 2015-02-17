#!/bin/sh

# Enable internal monitor and disable external monitor
# <https://wiki.archlinux.org/index.php/xrandr#Example_1>.
xrandr --output VGA1 --off --output LVDS1 --auto \
  && xset r rate 310 80
