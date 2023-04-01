
Fira Code


# Todo

- [x] install helix vscode barrier pywal
- [ ] increase key repeat
- [x] install chromium and floccus for sync
- [x] make way to control brightness
  - [ ] add key for brightness and volume
- [ ] audio and audio keys
- [x] right clicks and tap
- [x] change desktop with keys and gestures
- [x] find a terminal that I like and is fast
- [ ] try on different shells
- [x] find wallpaper
- [ ] backup dots
- [ ] fix font and emoji
  - [ ] fira code
- [x] create alias for xbps-install
- [ ] add common bashrc aliases like source ~/.bashrc


```
# # Volume control
# bindsym XF86AudioRaiseVolume    exec --no-startup-id pactl set-sink-volume 0 +5%
# bindsym XF86AudioLowerVolume    exec --no-startup-id pactl set-sink-volume 0 -5%
# bindsym XF86AudioMute           exec --no-startup-id pactl set-sink-mute 0 toggle

# Pulse Audio controls
bindsym XF86AudioRaiseVolume exec --no-startup-id pactl -- set-sink-volume 0 +5% #increase sound volume
bindsym XF86AudioLowerVolume exec --no-startup-id pactl -- set-sink-volume 0 -5% #decrease sound volume
bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute 0 toggle # mute sound

# Screen brightness controls with notification
bindsym XF86MonBrightnessUp exec light -A 5 # increase screen brightness
bindsym XF86MonBrightnessDown exec light -U 5 # decrease screen brightness

# Media player controls
bindsym XF86AudioPlay exec playerctl play-pause
bindsym XF86AudioNext exec playerctl next
bindsym XF86AudioPrev exec playerctl previous
```

# Installing flatpak

Note that the directories 

'/var/lib/flatpak/exports/share'
'/home/void/.local/share/flatpak/exports/share'

are not in the search path set by the XDG_DATA_DIRS environment variable, so
applications installed by Flatpak may not appear on your desktop until the
session is restarted.
