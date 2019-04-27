#!/bin/bash

# have the script exit as soon as one of its children fails with a
# non-0 exit
set -e

NAME=$(date +'%Y-%m-%d_%H:%M:%S.png')
SAVE_PATH="${HOME}/shots"
COMBINED="${save_path}/${name}"
echo ${COMBINED}

scrot -q 100 "${COMBINED}"
xclip -selection clipboard -t image/png -i "${COMBINED}"
zenity --info --width="280" --height=20 --title "Screenshot" --timeout=1 --text "Your screenshot has been Saved in \n $SAVE_PATH!" &>/dev/null
