#!/bin/sh

# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

BASEDIR="/$0"
BASEDIR="${BASEDIR%/*}"
BASEDIR="${BASEDIR:-.}"
BASEDIR="${BASEDIR##/}/"
BASEDIR=$(cd "$BASEDIR"; pwd)

HOMEBINDIR="$BASEDIR"
LOCALBINDIR="$BASEDIR"/../.local/bin
APPIMAGEDIR="$BASEDIR"/../Applications
