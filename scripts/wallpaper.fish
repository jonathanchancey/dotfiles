#!/usr/bin/fish

# screenshot_dir

# logging
date +"%a %b %d %I:%m %p" >> $HOME/.config/wal/changed.log

set -l file (random choice /home/coal/pictures/wallpapers/*)
wal -n -i $file

hyprctl hyprpaper preload $file

hyprctl hyprpaper wallpaper "DP-1,$file"
hyprctl hyprpaper wallpaper "DP-2,$file"

# hyprctl hyprpaper wallpaper "DP-2,/home/coal/pictures/wallpapers/haimerl.jpg"

