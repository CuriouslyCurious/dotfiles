#!/usr/bin/env fish
# Export the terminal
export TERM=foot

# Debug options are:
# 1 - for all
# client - for most debug messages
# server - will mostly not show anything unless more compisitors are run (afaict)
export WAYLAND_DEBUG=0

# Set desktop variables (makes waybar more functional)
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_DESKTOP=sway

# Will be used if certain env variables are not set for graphics APIs
export XDG_SESSION_TYPE=wayland

# Set the config home just in-case
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CONFIG_DIR="$HOME/.config"

# Set (and create) the XDG_RUNTIME_DIR if it does not exist
if test -z $XDG_RUNTIME_DIR
    set -x XDG_RUNTIME_DIR "/run/user/$USER"
    if not test -d $XDG_RUNTIME_DIR
        mkdir -p $XDG_RUNTIME_DIR -m 0700
    end
end

# Ensure we can find objects we've built by hand and not into debs
# export LD_LIBRARY_PATH=/usr/local/lib/x86_64-linux-gnu/

# wlroots thing
# export WLR_DRM_NO_MODIFIERS=1

# Java under XWayland (ew, gross), this prevents a blank screen that is probably a bug that
# is unlikely to be fixed
export _JAVA_AWT_WM_NONREPARENTING=1
# Force firefox into wayland and enable hw video decoding (ff 75+)
export MOZ_ENABLE_WAYLAND=1
export MOZ_WAYLAND_USE_VAAPI=1

# To open links in current Firefox instances
# https://bugzilla.mozilla.org/show_bug.cgi?id=1645038
export MOZ_DBUS_REMOTE=1

# GPG
export GPG_TTY=(tty)

# QT
export QT_QPA_PLATFORM=wayland-egl
export QT_QPA_PLATFORMTHEME=qt5ct
export QT_WAYLAND_DISABLE_WINDOWDECORATIONS="1"

# GTK (GDK is the subsystem of GTK that handles windowing)
export GDK_BACKEND=wayland

# SDL
export SDL_VIDEODRIVER=wayland
export ECORE_EVAS_ENGINE=wayland-egl

# ELM
export ELM_ENGINE=wayland-egl
export NO_AT_BRIDGE=1

# X11 variable used to select and X display, does not have a fallback
# export DISPLAY=:0

# If $WAYLAND_DISPLAY is somehow not set, set it ourselves
#if ! test -e "$WAYLAND_DISPLAY"
#    display_file=$(find "$XDG_RUNTIME_DIR" -type f -name "wayland-?")
#    if test -e "$display_file"
#        export WAYLAND_DISPLAY="$display_file"
#    end
#end

# Create a Dbus session for stupid stuff that needs one
export (dbus-launch)

#dbus-daemon --session --address=unix:path=$XDG_RUNTIME_DIR/bus

# Disgusting, to make screensharing on Wayland work (xdg-desktop-portal-wlr)
#systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
