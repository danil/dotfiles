#! /bin/sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

percentage=$(echo_sound_volume.sh)
bar_max_size=28
bar_symbol='#'
bar_size=$(echo ${bar_max_size}*$(echo_sound_volume.sh)/100 | bc)

if [[ ${percentage} -eq 'MM' ]]; then
    bar_size=0
fi

if [[ ${percentage} -gt 0 && ${bar_size} -eq 0 ]]; then
    bar_size=1
fi

# <http://stackoverflow.com/questions/5349718/how-can-i-repeat-a-character-in-bash#5349772>.
bar=$(for i in `seq 1 ${bar_size}`; do echo -n ${bar_symbol}; done)

# let xxx=${tmp%.*}

# <https://wiki.archlinux.org/index.php/Desktop_notifications#Usage_in_programming>.
dunstify --replace=1 "Sound volume ${percentage}%\n${bar}"
