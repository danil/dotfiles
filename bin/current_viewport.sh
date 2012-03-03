#! /bin/bash
# Pront current viewport number
# <http://superuser.com/questions/264281/wmctrl-says-i-have-one-workspace-when-i-actually-have-four#answer-264502>.
dimensions=$(xdpyinfo | awk '$1=="dimensions:"{print $2}')
screen_width=${dimensions%x*}
screen_height=${dimensions%x*}
info=( $(wmctrl -d | awk '{print $4, $6}') )
desktop_width=${info[0]%x*}
viewports=$(( desktop_width / screen_width ))
current_vp=$(( ${info[1]%,*} / screen_width ))

echo "$dimensions"
echo "$screen_width"
echo "$info"
echo "$desktop_width"
echo "$viewports"
echo "$current_vp"
