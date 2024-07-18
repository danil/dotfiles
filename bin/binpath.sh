#!/bin/sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

BASEDIR="/$0"
BASEDIR="${BASEDIR%/*}"
BASEDIR="${BASEDIR:-.}"
BASEDIR="${BASEDIR##/}/"
BASEDIR=$(cd "$BASEDIR"; pwd)

HOMEBINDIR="$BASEDIR"
LOCALBINDIR="$BASEDIR"/../.local/bin
USRLOCALBINDIR="$BASEDIR"/../.local/usr/local/bin
BREWBINDIR=/home/linuxbrew/.linuxbrew/bin
CONFIGDIR="$BASEDIR"/../.config
APPIMAGEDIR="$BASEDIR"/../Applications
NIXBINDIR="$BASEDIR"/../.nix-profile/bin/google-chrome-stable
