#!/bin/bash
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.
dbus-send --type=method_call --dest=org.gnome.ScreenSaver /org/gnome/ScreenSaver org.gnome.ScreenSaver.Lock
