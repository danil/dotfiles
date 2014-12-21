#!/bin/sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

# Custom X session <https://wiki.ubuntu.com/CustomXSession>.

# Make sure this is before the 'exec' command or it won't be sourced
# <https://wiki.archlinux.org/index.php/xprofile#Making_it_compatible_with_xinit>.
[ -f /etc/xprofile ] && source /etc/xprofile
[ -f ~/.xprofile ] && source ~/.xprofile

exec $1
