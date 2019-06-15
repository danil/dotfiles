#! /bin/bash
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

# Print screen backlight rounded string
# <http://stackoverflow.com/questions/2395284/round-a-divided-number-in-bash#2395601>.
echo $(printf "%.0f" `light -G`)
