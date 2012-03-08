#! /bin/bash
# X Window Manager show desktop
# <http://planetblur.org/hosted/awnforum/index.php?shard=forum&action=g_reply&ID=443>,
# <http://ubuntuforums.org/showthread.php?t=1615199#td_post_10083165>.
if wmctrl -m | grep -q '"showing the desktop" mode: ON'; then
    exec wmctrl -k off
else
    exec wmctrl -k on
fi
