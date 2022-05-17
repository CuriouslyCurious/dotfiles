#!/usr/bin/env fish

# More functional tray on waybar
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_DESKTOP=sway
# XDG shenanigans
export XDG_CONFIG_HOME="$HOME/.config"
if test -z $XDG_RUNTIME_DIR
    set -x XDG_RUNTIME_DIR /tmp/(id -u)-runtime
    if not test -d $XDG_RUNTIME_DIR
        mkdir -p $XDG_RUNTIME_DIR -m 0700
    end
end

source ~/scripts/wayland-envs.fish
sway -d 2>$HOME/.local/log/sway
