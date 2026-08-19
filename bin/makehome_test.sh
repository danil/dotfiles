#!/usr/bin/env sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

. /home/danil/bin/binpath.sh

SCRIPT_NAME="$HOMEBINDIR"/makehome

dash -n        "$SCRIPT_NAME"
bash -n        "$SCRIPT_NAME"
bash-3.2.57 -n "$SCRIPT_NAME"
bash-4.4.18 -n "$SCRIPT_NAME"
sh -n          "$SCRIPT_NAME"

dash        "$SCRIPT_NAME" --home="$HOME" --jobs="$(nproc)" --help
bash        "$SCRIPT_NAME" --home="$HOME" --jobs="$(nproc)" --help
bash-3.2.57 "$SCRIPT_NAME" --home="$HOME" --jobs="$(nproc)" --help
bash-4.4.18 "$SCRIPT_NAME" --home="$HOME" --jobs="$(nproc)" --help
sh          "$SCRIPT_NAME" --home="$HOME" --jobs="$(nproc)" --help
