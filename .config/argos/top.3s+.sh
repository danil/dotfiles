#!/usr/bin/env bash

echo "<span weight='normal'>$(/home/danil/.local/usr/local/bin/slstatus -s -1)</span>                          x | size=12 font='DejaVu Sans Mono'"
echo "---"

if [ "$ARGOS_MENU_OPEN" == "true" ]; then
    # http://stackoverflow.com/a/14853319
    TOP_OUTPUT=$(top -b -n 1 | head -n 20 | awk 1 ORS="\\\\n")
    echo "$TOP_OUTPUT | font=monospace bash=top"
else
    echo "Loading..."
fi
