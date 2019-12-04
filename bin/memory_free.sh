#! /bin/sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

# <http://unix.stackexchange.com/questions/68526/get-separate-used-memory-info-from-free-m-comand#68536>.
free --human | awk '/^Mem/ {printf("%s", $4);}'
