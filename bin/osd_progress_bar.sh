#! /bin/sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

function osd_progress_bar {
    local percentage=${1}
    if [[ -f /tmp/osd-progress-bar-size ]]; then
        local bar_max_size=$(cat /tmp/osd-progress-bar-size)
    else
        local bar_max_size=28
    fi
    local bar_max_size=${bar_max_size:-24}
    local bar_symbol='#'
    local bar_size=$(echo ${bar_max_size}*${percentage}/100 | bc)

    if [[ ${percentage} -eq 'MM' ]]; then
        bar_size=0
    fi

    if [[ ${percentage} -gt 0 && ${bar_size} -eq 0 ]]; then
        bar_size=1
    fi

    # <http://stackoverflow.com/questions/5349718/how-can-i-repeat-a-character-in-bash#5349772>.
    for i in `seq 1 ${bar_size}`; do echo -n ${bar_symbol}; done
}
