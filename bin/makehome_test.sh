#!/usr/bin/env sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

SCRIPT_NAME=makehome

. /home/danil/bin/binpath.sh
. "$HOMEBINDIR"/main_test.sh

$DASH  -n "$SCRIPT_PATH"
$BASH  -n "$SCRIPT_PATH"
$BASH3 -n "$SCRIPT_PATH"
$BASH4 -n "$SCRIPT_PATH"
$SH    -n "$SCRIPT_PATH"

$DASH  "$SCRIPT_PATH" --home="$HOME" --jobs="$(nproc)" --help
$BASH  "$SCRIPT_PATH" --home="$HOME" --jobs="$(nproc)" --help
$BASH3 "$SCRIPT_PATH" --home="$HOME" --jobs="$(nproc)" --help
$BASH4 "$SCRIPT_PATH" --home="$HOME" --jobs="$(nproc)" --help
$SH    "$SCRIPT_PATH" --home="$HOME" --jobs="$(nproc)" --help
