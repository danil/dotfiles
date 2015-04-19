#! /bin/sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

free --human | awk '/^Mem/ {printf("%s", $4);}'
