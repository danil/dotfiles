#!/bin/sh

# Disable internal monitor and enable external monitor
# <https://wiki.archlinux.org/index.php/xrandr#Example_1>.
xrandr --output LVDS1 --off --output VGA1 --auto
