#!/usr/bin/env sh
# This file is part of Danil Kutkevich <danil@kutkevich.org> home.

set -e

# <https://github.com/madhead/shyriiwook>,
# <https://reddit.com/r/gnome/comments/1lzafzw/a_simple_gnome_shell_extension_to_switch_keyboard>.
if gdbus introspect --session --dest org.gnome.Shell  --object-path /me/madhead/Shyriiwook  --only-properties | grep -Eq "currentLayout = 'us'"; then
    gdbus call --session --dest org.gnome.Shell --object-path /me/madhead/Shyriiwook --method me.madhead.Shyriiwook.activate "ru"
    ibus engine 'xkb:ru::rus'
    alacritty msg config "colors.cursor.cursor='#00ffff'"
    tmux -S /tmp/tmux-pair set -t $(hostname | cut -d. -f1) -g cursor-colour brightcyan
else
    gdbus call --session --dest org.gnome.Shell --object-path /me/madhead/Shyriiwook --method me.madhead.Shyriiwook.activate "us"
    ibus engine 'xkb:us::eng'
    alacritty msg config "colors.cursor.cursor='#ff0000'"
    tmux -S /tmp/tmux-pair set -t $(hostname | cut -d. -f1) -g cursor-colour brightred
fi
