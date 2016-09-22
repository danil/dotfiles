#! /bin/sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.
killall xautolock &> /dev/null
xautolock -time 10 \
          -notify 10 \
          -notifier "notify-send --urgency=low 'Lock' 'in 10 seconds'" \
          -locker ~/bin/my_lock.sh &
