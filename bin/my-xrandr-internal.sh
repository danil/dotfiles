#!/bin/bash
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

# Enable internal monitor and disable external monitor
# <https://wiki.archlinux.org/index.php/xrandr#Example_1>.
xrandr --output HDMI1 --off --output eDP1 --auto \
    && ~/bin/my-keyboard-auto-repeat-rate.sh \
    && ~/bin/set_osd_progress_bar_size.sh