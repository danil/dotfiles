#!/bin/bash
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

xwininfo -root \
    | grep Width: \
    | sed --expression='s|.*Width: \([0-9]*\).*|\1/34.5|' \
    | bc
