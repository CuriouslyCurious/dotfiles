#
#  ███████╗███████╗██╗  ██╗
#  ╚══███╔╝██╔════╝██║  ██║
#    ███╔╝ ███████╗███████║
#   ███╔╝  ╚════██║██╔══██║
#  ███████╗███████║██║  ██║
#  ╚══════╝╚══════╝╚═╝  ╚═╝
#
# Curious' zsh config

##################
##### Basics #####
##################

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

zstyle :compinstall filename '$HOME/.zshrc'

# Start zsh completion system
autoload -Uz compinit && compinit

# Set completion to ignore case
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'

case "$TERM" in
    xterm-color) color_prompt=yes;;
    xterm-256color) color_prompt=yes;;
    rxvt-unicode-256color) color_prompt=yes;;
    screen-256color) color_prompt=yes;;
esac

# Termite rarely plays well with ssh and such
export TERM=xterm-256color

# Stupid bell
set bell-style none

# Disable case sensitivity
CASE_SENSITIVE="true"

setopt extendedglob

# Disable Software Flow Control
# https://unix.stackexchange.com/questions/72086/ctrl-s-hang-terminal-emulator#72092
stty -ixon

# Lower timeout delay (might cause issues)
# Default = 40
export KEYTIMEOUT=1

####################
##### Antibody #####
####################

source <(antibody init)
antibody bundle < $HOME/.zsh_plugins

#####################
##### Functions #####
#####################

# Run ls -a on entering a new directory
# Also save that dir to ~/.last_dir to make it easier to launch a terminal in that directory
function chpwd() {
    emulate -L zsh
    ls -a --color=auto
    pwd > ~/.last_dir
}

####################
##### Keybinds #####
####################

# vi-mode (https://github.com/ajh17/dotfiles/blob/master/.zshrc#L164)
#bindkey -v
#autoload -Uz edit-command-line
#zle -N edit-command-line
#
#bindkey -M vicmd "/" history-incremental-pattern-search-forward
#bindkey -M vicmd "?" history-incremental-pattern-search-backward
#bindkey -M vicmd '^g' what-cursor-position
#bindkey -M vicmd '^r' redo
#bindkey -M vicmd 'G' end-of-buffer-or-history
#bindkey -M vicmd 'gg' beginning-of-buffer-or-history
#bindkey -M vicmd 'u' undo
#bindkey -M vicmd '~' vi-swap-case
#bindkey -M vicmd '^v' edit-command-line
#bindkey -a '^[[3~' delete-char
#bindkey '^?' backward-delete-char
#bindkey '^[[Z' reverse-menu-complete
#bindkey '^a' vi-insert-bol
#bindkey '^_' run-help
#bindkey '^e' vi-add-eol
#bindkey '^k' kill-line
#bindkey '^l' clear-screen
#bindkey '^n' insert-last-word
#bindkey '^r' history-incremental-search-backward
#bindkey '^s' history-incremental-search-forward
#bindkey '^u' vi-change-whole-line
[[ -n ${key[PageUp]} ]] && bindkey "${key[PageUp]}" up-line-or-history
[[ -n ${key[PageDown]} ]] && bindkey "${key[PageDown]}" down-line-or-history

bindkey "^[OH" beginning-of-line
bindkey "^[OF" end-of-line

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

#bindkey -M vicmd 'k' history-substring-search-up
#bindkey -M vicmd 'j' history-substring-search-down

# vi-mode is dumb, so this needs to be added
# start typing + [Up-Arrow] - fuzzy find history forward
#if [[ "${terminfo[kcuu1]}" != "" ]]; then
#  autoload -U up-line-or-beginning-search
#  zle -N up-line-or-beginning-search
#  bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
#fi
## start typing + [Down-Arrow] - fuzzy find history backward
#if [[ "${terminfo[kcud1]}" != "" ]]; then
#  autoload -U down-line-or-beginning-search
#  zle -N down-line-or-beginning-search
#  bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
#fi

bindkey "^ " autosuggest-accept

##########################
##### Plugin options #####
##########################

# Load in .zfunc
fpath+=~/.zfunc

# Spacehip theme
#autoload -Uz promptinit; promptinit
#ZSH_THEME="spaceship"
#SPACESHIP_BATTERY_SHOW=false
#SPACESHIP_BATTERY_PREFIX=""
#SPACESHIP_BATTERY_SUFFIX=" "
#SPACESHIP_VI_MODE_SHOW=true

export STARSHIP_CONFIG=$HOME/.config/starship/config.toml
export STARSHIP_CACHE=$HOME/.config/starship/cache

# zsh-history-substring-search
# Skip duplicates
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=true

# zsh-vi-mode
#ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_UNDERLINE
#ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK

##########################
##### Other programs #####
##########################

# Set .dircolors
if [[ -e $HOME/.dircolors ]]; then
    eval $(dircolors -b $HOME/.dircolors)
fi

# Run ssh-agent
# https://wiki.archlinux.org/index.php/SSH_keys#SSH_agents
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "$HOME/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    source "$HOME/ssh-agent.env" >/dev/null
fi

export PATH="$HOME/.local/bin:$PATH"

# Export rustup to $PATH if it exists
if [[ -e $HOME/.cargo/env ]]; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi

# Export go/bin to $GOPATH if it exists and then export to $PATH
if [[ -d $HOME/go/bin ]]; then
    export GOPATH="$HOME/go/bin"
    export PATH="$GOPATH:$PATH"
fi

# Export gem path to $PATH if it exists
if [[ -d "$HOME/.gem/ruby/2.5.0/bin" ]]; then
    export PATH="$HOME/.gem/ruby/2.5.0/bin:$PATH"
fi

# Export dotfile's script dir to $PATH if it exists
if [[ -d "$HOME/scripts" ]]; then
    export PATH="$HOME/scripts:$PATH"
fi

# Automatically execute direnv file
if [[ -e $(which direnv) ]]; then
    eval "$(direnv hook zsh)"
fi

# Load aliases
if [[ -e $HOME/.aliases ]]; then
    source $HOME/.aliases
fi

# Set editor
if [[ -f $(which nvim) ]]; then
    export EDITOR=$(which nvim)
elif [[ -f $(which vim) ]]; then
    export EDITOR=$(which vim)
else
    export EDITOR=$(which nano)
fi

# OPAM configuration
if [[ -d "$HOME/.opam" ]]; then
    . /home/curious/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
fi

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

##################
#### Greeting ####
##################
if [[ -f $(which neofetch) ]]; then
	neofetch
fi

echo ""

if [[ -f $(which task) ]]; then
	task
fi


