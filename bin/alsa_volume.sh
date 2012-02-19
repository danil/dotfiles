#! /bin/bash
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.
amixer get PCM \
 | awk -F'[]%[]' 'OFS = ""; /%/ {if ($7 == "off") { print "MM" } else { print $2 }}' \
 | head -n 1
