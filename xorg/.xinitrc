#!/bin/sh
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap
xbindkeys=$HOME/.xbindkeysrc

# Start the window manager
if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
    exec startx
fi

# Set typematic delay
xset r rate 300 35

# Set keyboard layout
setxkbmap -option grp:alt_shift_toggle -layout se,us

# Set some shortcuts
xbindkeys

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

if [ -f "$xbindkeys" ]; then
    xbindkeys
fi

if [ -f "$HOME/.fonts" ]; then
    xset +fp /home/curious/.fonts
    xset fp rehash
fi

if [ -f "/usr/bin/unclutter" ]; then
    unclutter &
fi

exec i3

