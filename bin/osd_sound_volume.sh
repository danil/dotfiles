#! /bin/sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

source osd_progress_bar.sh

percentage=$(echo_sound_volume.sh)

# <https://wiki.archlinux.org/index.php/Desktop_notifications#Usage_in_programming>.
dunstify --replace=1 \
         "♪ Sound volume ${percentage}%" \
         "$(osd_progress_bar ${percentage})"
