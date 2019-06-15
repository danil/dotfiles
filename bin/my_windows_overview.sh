#! /bin/bash
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.
dbus-send --session --type=method_call --dest=org.gnome.Shell /org/gnome/Shell org.gnome.Shell.Eval string:'Main.overview.show();'
