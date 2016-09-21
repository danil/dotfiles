#! /bin/sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.
killall xautolock 2> /dev/null
xautolock -time 10 -locker ~/bin/my-lock.sh &
