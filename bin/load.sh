#! /bin/sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.
# <http://en.wikipedia.org/wiki/Load_(computing)>
echo "$(uptime| sed -e 's/.*load average: \([^,]*\),.*/\1/')"
