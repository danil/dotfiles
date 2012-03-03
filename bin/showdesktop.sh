#! /bin/bash
# X Window Manager show desktop
# <http://ubuntuforums.org/showthread.php?t=1615199#td_post_10083165>.
if wmctrl -m | grep "mode: ON"; then
    exec wmctrl -k off
else
    exec wmctrl -k on
fi
