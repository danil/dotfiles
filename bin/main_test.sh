#!/usr/bin/env sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

SCRIPT_PATH="$HOMEBINDIR"/"$SCRIPT_NAME"

noop () { echo "WARNING: missing test interpreter $@"; }

DASH="dash"         && command -v "$DASH" >/dev/null 2>&1  || DASH="noop $DASH"
BASH="bash"         && command -v "$BASH" >/dev/null 2>&1  || BASH="noop $BASH"
BASH3="bash-3.2.57" && command -v "$BASH3" >/dev/null 2>&1 || BASH3="noop $BASH3"
BASH4="bash-4.4.18" && command -v "$BASH4" >/dev/null 2>&1 || BASH4="noop $BASH4"
SH="sh"             && command -v "$SH"    >/dev/null 2>&1 || SH="noop $SH"
