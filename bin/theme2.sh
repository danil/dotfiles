#!/usr/bin/env sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

. "$(cd -- "$(dirname -- "$0")" >/dev/null 2>&1 && pwd -P)/path.sh"

printf "%s\n" $(date --utc +%Y%m%dT%H%M%SZ) >> /tmp/danil/123.txt
