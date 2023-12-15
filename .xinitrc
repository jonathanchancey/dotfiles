#!/bin/sh
#ec xterm -geometry 80x66+0+0 -name login
# exec /home/new/scripts/launch-dwm.sh
# exec dwm
screenconfig.sh &
syncthing &
pipewire &
nitrogen --restore &
dunst &
dwmblocks &
picom -CG --no-fading-openclose &
xset r rate 185 30
while type dwm >/dev/null ; do dbus-run-session dwm && continue || break ; done
# dwm >> /home/new/apps/dwm/dwm.log 2>&1
