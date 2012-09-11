#!/bin/bash
#
# devans 2008-07-19
# This script will check to see if electricsheep is running, and if so, it will do nothing
# If it is not running, it will invoke xscreensave-command -deactivate to prevent xscreensaver
# from running.  Mostly this is useful is set as the command to call via heartbeat-cmd in
# ~/.mplayer/config
# <http://fugutabetai.com/?postid=292>.

# Mplayer slave mode protocol <http://www.mplayerhq.hu/DOCS/tech/slave.txt>.
if [[ -z $(ps -ef | grep electricsheep | grep -v grep) ]] ; then
    xscreensaver-command -deactivate
else
    echo $(ps ux | awk '/mplayer/ && !/awk/ {print $2}') > ~/.mplayer/tmp.pid #TODO: Rremove extra tmp.pid after fix 'bash: !/awk/: event not found'
    if [[ "$(cat ~/.mplayer/tmp.pid)" != "$(cat ~/.mplayer/mplayer.pid)" ]] ; then
        echo $(ps ux | awk '/mplayer/ && !/awk/ {print $2}') > ~/.mplayer/mplayer.pid
        echo 'switch_ratio 1.6' > ~/.mplayer/mplayer.pipe
        echo 'vo_fullscreen 1'  > ~/.mplayer/mplayer.pipe
    fi
fi
