#! /bin/sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

killall trayer-srg 2> /dev/null
trayer-srg \
    --edge top \
    --align right \
    --widthtype request \
    --height 22 \
    --distancefrom right --distance 490 \
    --transparent true \
    --alpha 0 \
    --tint 000000 &

killall xxkb 2> /dev/null
xxkb &
