#!/usr/bin/env sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

. /home/danil/bin/binpath.sh

SCRIPT_NAME=gitpushmirror
SCRIPT_PATH="$HOMEBINDIR"/"$SCRIPT_NAME"

dash -n        "$SCRIPT_PATH"
bash -n        "$SCRIPT_PATH"
bash-3.2.57 -n "$SCRIPT_PATH"
bash-4.4.18 -n "$SCRIPT_PATH"
sh -n          "$SCRIPT_PATH"
