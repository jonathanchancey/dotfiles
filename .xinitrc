#!/bin/sh
ec xterm -geometry 80x66+0+0 -name login
# exec /home/new/scripts/launch-dwm.sh
# exec dwm
while type dwm >/dev/null ; do dwm && continue || break ; done

