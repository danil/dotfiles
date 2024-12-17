#!/bin/sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

f=/tmp/dwm.fifo
rm -f $f
mkfifo $f
/home/kutkevich.danil/.local/usr/local/bin/dwm
