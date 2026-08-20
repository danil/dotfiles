#!/usr/bin/env sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

SCRIPT_NAME=theme.sh

. /home/danil/bin/binpath.sh
. "$HOMEBINDIR"/main_test.sh

$DASH  -n "$SCRIPT_PATH"
$BASH  -n "$SCRIPT_PATH"
$BASH3 -n "$SCRIPT_PATH"
$BASH4 -n "$SCRIPT_PATH"
$SH    -n "$SCRIPT_PATH"

$DASH  "$SCRIPT_PATH" --help
$BASH  "$SCRIPT_PATH" --help
$BASH3 "$SCRIPT_PATH" --help
$BASH4 "$SCRIPT_PATH" --help
$SH    "$SCRIPT_PATH" --help
