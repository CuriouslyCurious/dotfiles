# Enable vi mode
fish_vi_key_bindings

# Set default editor
if which nvim > /dev/null 2>&1
	set -U EDITOR nvim
else if which vim > /dev/null 2>&1
	set -U EDITOR vim
else
	set -U EDITOR nano
end

# Run ssh-agent
# https://wiki.archlinux.org/index.php/SSH_keys#SSH_agents
if ! pgrep -u "$USER" ssh-agent > /dev/null
    ssh-agent -c -t 1h > "$HOME/.ssh/ssh-agent.env"
end
if test -e "$SSH_AUTH_SOCK"
    eval "$HOME/.ssh/ssh-agent.env" > /dev/null
end

set -U PATH "$HOME/.local/bin:$PATH"

# Export rustup to $PATH if it exists
if test -e $HOME/.cargo/env
    set -U PATH "$HOME/.cargo/bin:$PATH"
end

# Export go/bin to $GOPATH if it exists and then set -U to $PATH
if test -d $HOME/go/bin
    set -U GOPATH "$HOME/go/bin"
    set -U PATH "$GOPATH:$PATH"
end

# Export gem path to $PATH if it exists
if test -d "$HOME/.gem/ruby/2.5.0/bin"
    set -U PATH "$HOME/.gem/ruby/2.5.0/bin:$PATH"
end

# Export dotfile's script dir to $PATH if it exists
if test -d "$HOME/scripts"
    set -U PATH "$HOME/scripts:$PATH"
end

# Load dircolors
# eval (gdircolors ~/.dircolors)

# Load prompt
starship init fish | source
