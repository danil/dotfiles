#!/usr/bin/env sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

SCRIPT_NAME=gitbundlearchive.sh

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

tempin=$(mktemp --directory /tmp/"$SCRIPT_NAME"_in.XXXXXX)
tempout=$(mktemp --directory /tmp/"$SCRIPT_NAME"_out.XXXXXX)

$DASH  "$SCRIPT_PATH" --in="$tempin" --out="$tempout"
$BASH  "$SCRIPT_PATH" --in="$tempin" --out="$tempout"
$BASH3 "$SCRIPT_PATH" --in="$tempin" --out="$tempout"
# $BASH4 "$SCRIPT_PATH" --in="$tempin" --out="$tempout" # FIXME: Fix infinity loop error.~~~~<danil@kutkevich.org>
$SH    "$SCRIPT_PATH" --in="$tempin" --out="$tempout"

rmdir "$tempin"
rmdir "$tempout"
