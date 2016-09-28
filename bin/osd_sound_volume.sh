#! /bin/sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

source osd_progress_bar.sh

percentage=$(echo_sound_volume.sh)

# <https://wiki.archlinux.org/index.php/Desktop_notifications#Usage_in_programming>.
dunstify --replace=1 --urgency=low \
         "♪ $(printf '%3s' ${percentage})%" \
         "$(osd_progress_bar ${percentage})"
