#! /bin/sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.
killall xautolock 2> /dev/null
xautolock -time 10 \
          -notify 10 \
          -notifier "notify-send --urgency=low 'Lock' 'in 10 seconds'" \
          -locker ~/bin/my-lock.sh &
