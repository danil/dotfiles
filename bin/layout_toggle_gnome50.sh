#!/usr/bin/env sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

set -e

# Presses Super+Space down and releases them <sup><sub>`sudo pkill ydotoold ; sudo ydotoold --socket-path="/run/user/1000/.ydotool_socket" --socket-own="1000:1000" &`</sub></sup>.
ydotool key 125:1 57:1 57:0 125:0
