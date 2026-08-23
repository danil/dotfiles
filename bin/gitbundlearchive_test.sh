#!/usr/bin/env sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

. "$(cd -- "$(dirname -- "$0")" >/dev/null 2>&1 && pwd -P)/stdt.sh"

$TESTDASH  -n "$TESTED_PATH"
$TESTBASH  -n "$TESTED_PATH"
$TESTBASH3 -n "$TESTED_PATH"
$TESTBASH4 -n "$TESTED_PATH"
$TESTSH    -n "$TESTED_PATH"

$TESTDASH  "$TESTED_PATH" --help
$TESTBASH  "$TESTED_PATH" --help
$TESTBASH3 "$TESTED_PATH" --help
$TESTBASH4 "$TESTED_PATH" --help
$TESTSH    "$TESTED_PATH" --help

tempin=$(mktemp --directory /tmp/"$TESTED_NAME"_in.XXXXXX)
tempout=$(mktemp --directory /tmp/"$TESTED_NAME"_out.XXXXXX)

$TESTDASH  "$TESTED_PATH" --in="$tempin" --out="$tempout"
$TESTBASH  "$TESTED_PATH" --in="$tempin" --out="$tempout"
$TESTBASH3 "$TESTED_PATH" --in="$tempin" --out="$tempout"
# $TESTBASH4 "$TESTED_PATH" --in="$tempin" --out="$tempout" # FIXME: Fix infinity loop error.~~~~<danil@kutkevich.org>
# $TESTSH    "$TESTED_PATH" --in="$tempin" --out="$tempout" # FIXME: Fix infinity loop error.~~~~<danil@kutkevich.org>

rmdir "$tempin"
rmdir "$tempout"
