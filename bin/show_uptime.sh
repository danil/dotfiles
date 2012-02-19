#! /bin/bash
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.
# <http://en.wikipedia.org/wiki/Load_(computing)>
notify-send "$(uptime| sed -e 's/[:,]//g; s/.*\(load.*\)/\1/')"

# Overcomplicated.
# echo $(top -b -n 1 \
#         |sed -n '/^top/ { h; d }
#                  /^Cpu/ {
#                    s/.* \([0-9]*\.[0-9]*%\)us.*/\1/p
#                    g }
#                  /^top/ {
#                    s/,//g
#                    s/.* average: \(\)/\1/p }')
