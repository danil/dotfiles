#!/bin/sh

# Enable internal monitor and disable external monitor
# <https://wiki.archlinux.org/index.php/xrandr#Example_1>.
xrandr --output VGA1 --off --output HDMI1 --off --output LVDS1 --auto \
    && ~/bin/my-keyboard-auto-repeat-rate.sh \
    && ~/bin/set_osd_progress_bar_size.sh
