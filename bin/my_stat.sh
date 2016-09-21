#! /bin/sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

killall i3status
killall dzen2
i3status \
    | ~/src/python/i3-dzen2-bridge/i3-dzen-bridge.py \
    | ~/bin/my-dzen2.sh &
