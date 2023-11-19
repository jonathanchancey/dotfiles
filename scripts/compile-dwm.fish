#!/usr/bin/fish
cd /home/new/apps/dwm 

if sudo make install; notify-send "dwm make install" "success"
else; notify-send "dwm make install" "failed"
end

cd -
