#! /bin/sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

df --human-readable --output=avail / \
    | sed --quiet --expression='1!p' \
    | sed --expression='s/[^0-9]*\([0-9.KMGT]*\).*/\1/'
