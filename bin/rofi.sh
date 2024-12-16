#!/usr/bin/env sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

. binpath.sh

"$USRLOCALBINDIR"/rofi -show combi -modi top -modes [run,drun,window,windowcd,combi,top,keys,filebrowser,recursivebrowser]
