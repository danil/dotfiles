#! /bin/bash
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

export min=${min:-0}
export max=${min:-10}
export file=${file:-/home/danil/.local/share/sounds/battery.oga}

while [ $# -gt 0 ]; do
    case "$1" in
        --min=*)
            let min="${1#*=}"
            ;;
        --max=*)
            let max="${1#*=}"
            ;;
        --critical)
            export file=/home/danil/.local/share/sounds/critical.oga
            ;;
        *)
            printf "***************************\n"
            printf "* Error: Invalid argument.*\n"
            printf "***************************\n"
            exit 1
    esac
    shift
done

percentage=$(/home/danil/bin/echo_battery_percentage.sh)
status=$(cat /sys/class/power_supply/AC/online)

command="/usr/bin/play $file"

if [ $percentage -ge $min ] \
       && [ $percentage -le $max ] \
       && [ $status == "0" ] \
       && [ -f $file ]; then
    $command 2> /dev/null
fi
