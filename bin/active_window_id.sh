#! /bin/sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.
# Get active window id
# <http://superuser.com/questions/382616/detecting-currently-active-window#533254>.
xprop -root 32x '\t$0' _NET_ACTIVE_WINDOW | cut -f 2
