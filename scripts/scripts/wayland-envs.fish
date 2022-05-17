#!/usr/bin/env fish
# Export the terminal
export TERM=foot

# Ensure we can find objects we've built by hand and not into debs
# export LD_LIBRARY_PATH=/usr/local/lib/x86_64-linux-gnu/

# wlroots thing
# export WLR_DRM_NO_MODIFIERS=1

# Java under XWayland
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
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME=qt5ct
export QT_WAYLAND_DISABLE_WINDOWDECORATIONS="1"

# SDL
export SDL_VIDEODRIVER=wayland

export ECORE_EVAS_ENGINE=wayland-egl

# ELM
export ELM_ENGINE=wayland-egl

export NO_AT_BRIDGE=1

# Maybe?
# export DISPLAY=$WAYLAND_DISPLAY


# Start ssh agent
if not pgrep -u "$USER" ssh-agent > /dev/null
    ssh-agent -c -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
end

if not test -e "$SSH_AUTH_SOCK"
    source "$XDG_RUNTIME_DIR/ssh-agent.env" > /dev/null 2>&1
end

export (dbus-launch)
