#! /bin/bash
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

# Frink.
# present:                 yes
# capacity state:          ok
# charging state:          charging
# present rate:            38918 mW
# remaining capacity:      28420 mWh
# present voltage:         11997 mV

# Milhouse.
# present:                 yes
# capacity state:          ok
# charging state:          charged
# present rate:            unknown
# remaining capacity:      100 mAh
# present voltage:         8262 mV

dunstify "$(echo $(cat /proc/acpi/battery/BAT0/state \
                    |sed -n -e '/^charging/ s/^.*:[ ]*\(\)/\1/p' \
                            -e '/^remaining/ s/^.*:[ ]*\(\)/\1/p'))"
