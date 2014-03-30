#! /bin/sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.
# <http://en.wikipedia.org/wiki/Load_(computing)>
notify-send "$(uptime| sed -e 's/[:,]//g; s/.*\(load.*\)/\1/')"
