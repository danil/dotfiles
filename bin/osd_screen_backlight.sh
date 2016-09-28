#! /bin/sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

source osd_progress_bar.sh

percentage=$(echo_screen_backlight.sh)

# ☼ <https://wiki.archlinux.org/index.php/Desktop_notifications#Usage_in_programming>.
dunstify --replace=1 --urgency=low \
         "☀ ${percentage}%" \
         "$(osd_progress_bar ${percentage})"
