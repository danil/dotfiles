#!/bin/sh

# Disable internal monitor and enable external monitor
# <https://wiki.archlinux.org/index.php/xrandr#Example_1>.
internal_display="LVDS1"
external_display="HDMI1"

if (xrandr | grep "$external_display connected" >/dev/null 2>&1); then
    xrandr --output $internal_display --off \
           --output $external_display --auto \
    && ~/bin/my-keyboard-auto-repeat-rate.sh
fi
