#! /bin/bash
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.
# <http://en.wikipedia.org/wiki/Load_(computing)>
dunstify "$(uptime | sed -e 's/[:,]//g; s/.*\(load.*\)/\1/')"
