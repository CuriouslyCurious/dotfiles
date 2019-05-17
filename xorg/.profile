if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

eval "$(dircolors ~/.dircolors/dircolors.ansi-universal)"

xrandr --output DisplayPort-0 --auto --output HDMI-0 --right-of DisplayPort-0 --auto --output DVI-0 --auto --left-of DisplayPort-0

export PATH="$HOME/.cargo/bin:$PATH"
