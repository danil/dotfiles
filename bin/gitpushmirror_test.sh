#!/usr/bin/env sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

. "$(cd -- "$(dirname -- "$0")" >/dev/null 2>&1 && pwd -P)/stdt.sh"

$TESTDASH  -n "$TESTED_PATH"
$TESTBASH  -n "$TESTED_PATH"
$TESTBASH3 -n "$TESTED_PATH"
$TESTBASH4 -n "$TESTED_PATH"
$TESTSH    -n "$TESTED_PATH"
