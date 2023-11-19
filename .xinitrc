#!/bin/sh
#ec xterm -geometry 80x66+0+0 -name login
# exec /home/new/scripts/launch-dwm.sh
# exec dwm
hwclock --hctosys
screenconfig.sh &
syncthing &
pipewire &
nitrogen --restore &
dunst &
dwmblocks &
while type dwm >/dev/null ; do dbus-run-session dwm && continue || break ; done
# dwm >> /home/new/apps/dwm/dwm.log 2>&1
