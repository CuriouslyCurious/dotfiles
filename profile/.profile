eval "$(dircolors ~/.dircolors)"

# Set default editor
if which nvim > /dev/null 2>&1; then
	export EDITOR nvim
elif which vim > /dev/null 2>&1; then
	export EDITOR vim
else
	export EDITOR=vi
fi

# Run ssh-agent
# https://wiki.archlinux.org/index.php/SSH_keys#SSH_agents
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -c -t 1h > "$HOME/.ssh/ssh-agent.env"
fi
if test -e "$SSH_AUTH_SOCK"; then
    eval "$HOME/.ssh/ssh-agent.env" > /dev/null
fi

# Export .local/bin
if test -d "$HOME/.local/bin"; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# Export rustup to $PATH if it exists
if test -d "$HOME/.cargo/bin"; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi

# Export go/bin to $GOPATH if it exists and then export -U to $PATH
if test -d "$HOME/go/bin"; then
    export GOPATH="$HOME/go/bin"
    export PATH="$GOPATH:$PATH"
fi

# Export gem path to $PATH if it exists
if test -d "$HOME/.gem/ruby/2.5.0/bin"; then
    export PATH="$HOME/.gem/ruby/2.5.0/bin:$PATH"
fi

# Export dotfile's script dir to $PATH if it exists
if test -d "$HOME/scripts"; then
    export PATH="$HOME/scripts:$PATH"
fi

# Export cargo bin
if test -d "$HOME/.cargo/bin"; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi
. "$HOME/.cargo/env"
