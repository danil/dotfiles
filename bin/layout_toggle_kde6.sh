#!/usr/bin/env sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

set -e

if busctl --user call org.kde.keyboard /Layouts org.kde.KeyboardLayouts getLayout | grep -Eq "u 0"; then
    qdbus6 org.kde.keyboard /Layouts org.kde.KeyboardLayouts.setLayout 1
    alacritty msg config "colors.cursor.cursor='#00ffff'"
    tmux -S /tmp/tmux-pair set -t $(hostname | cut -d. -f1) -g cursor-colour brightcyan
else
    qdbus6 org.kde.keyboard /Layouts org.kde.KeyboardLayouts.setLayout 0
    alacritty msg config "colors.cursor.cursor='#ff0000'"
    tmux -S /tmp/tmux-pair set -t $(hostname | cut -d. -f1) -g cursor-colour brightred
fi
