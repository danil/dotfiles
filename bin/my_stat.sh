#! /bin/bash
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

killall i3status &> /dev/null
killall dzen2 &> /dev/null
i3status \
    | ~/src/python/i3-dzen2-bridge/i3-dzen-bridge.py \
    | ~/bin/my_dzen2.sh &
