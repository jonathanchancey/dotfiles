#!/bin/bash
export LIBVA_DRIVER_NAME=nvidia
export XDG_SESSION_TYPE=wayland
export GMB_BACKEND=nvidia-drm
export __GLX_VENDOR_LIBRARY_NAME=NVIDIA
# __GLX_VENDOR_LIBRARY_NAME=NVIDIA
# __NV_PRIME_RENDER_OFFLOAD=1
export WLR_NO_HARDWARE_CURSORS=1

exec dbus-run-session Hyprland

# sleep 5
# exec /home/coal/.local/bin/set-monitor.sh

