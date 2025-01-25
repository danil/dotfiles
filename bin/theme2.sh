#!/usr/bin/env sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

. /home/danil/bin/binpath.sh

printf "%s\n" $(date --utc +%Y%m%dT%H%M%SZ) >> /tmp/danil/123.txt
