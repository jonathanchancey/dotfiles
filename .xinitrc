#!/bin/sh
#ec xterm -geometry 80x66+0+0 -name login
# exec /home/new/scripts/launch-dwm.sh
# exec dwm
syncthing &
nitrogen --restore &
pipewire &
while type dwm >/dev/null ; do dbus-run-session dwm && continue || break ; done

