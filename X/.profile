if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

eval "$(dircolors ~/.dircolors/dircolors.ansi-universal)"

export PATH="$HOME/.cargo/bin:$PATH"
