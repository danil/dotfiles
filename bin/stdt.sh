#!/usr/bin/env sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

TESTED_NAME="$(basename "$0" | sed s/_test//)"
TESTED_PATH="$(cd -- "$(dirname -- "$0")" >/dev/null 2>&1 && pwd -P)/$TESTED_NAME"

printf "STDT: testing %s\n" "$TESTED_PATH"

stdtnoop () { echo "WARNING: missing $@"; }

TESTDASH="dash"   && command -v "$TESTDASH" >/dev/null 2>&1  || TESTDASH="stdtnoop $TESTDASH"
TESTBASH="bash"   && command -v "$TESTBASH" >/dev/null 2>&1  || TESTBASH="stdtnoop $TESTBASH"
TESTBASH3="bash3" && command -v "$TESTBASH3" >/dev/null 2>&1 || TESTBASH3="stdtnoop $TESTBASH3"
TESTBASH4="bash4" && command -v "$TESTBASH4" >/dev/null 2>&1 || TESTBASH4="stdtnoop $TESTBASH4"
TESTSH="sh"       && command -v "$TESTSH"    >/dev/null 2>&1 || TESTSH="stdtnoop $TESTSH"
