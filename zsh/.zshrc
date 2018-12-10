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

autoload -Uz compinit

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

# run ls -a on entering a new directory
function chpwd() {
    emulate -L zsh
    ls -a
}

####################
##### Keybinds #####
####################

# vi-mode (https://github.com/ajh17/dotfiles/blob/master/.zshrc#L164)
bindkey -v
autoload -Uz edit-command-line
zle -N edit-command-line

bindkey -M vicmd "/" history-incremental-pattern-search-forward
bindkey -M vicmd "?" history-incremental-pattern-search-backward
bindkey -M vicmd '^g' what-cursor-position
bindkey -M vicmd '^r' redo
bindkey -M vicmd 'G' end-of-buffer-or-history
bindkey -M vicmd 'gg' beginning-of-buffer-or-history
bindkey -M vicmd 'u' undo
bindkey -M vicmd '~' vi-swap-case
bindkey -M vicmd '^v' edit-command-line
bindkey -a '^[[3~' delete-char
bindkey '^?' backward-delete-char
bindkey '^[[Z' reverse-menu-complete
bindkey '^a' vi-insert-bol
bindkey '^_' run-help
bindkey '^e' vi-add-eol
bindkey '^k' kill-line
bindkey '^l' clear-screen
bindkey '^n' insert-last-word
bindkey '^r' history-incremental-search-backward
bindkey '^s' history-incremental-search-forward
bindkey '^u' vi-change-whole-line
[[ -n ${key[PageUp]} ]] && bindkey "${key[PageUp]}" up-line-or-history
[[ -n ${key[PageDown]} ]] && bindkey "${key[PageDown]}" down-line-or-history

bindkey "^[OH" beginning-of-line
bindkey "^[OF" end-of-line

# vi-mode is dumb, so this needs to be added
# start typing + [Up-Arrow] - fuzzy find history forward
if [[ "${terminfo[kcuu1]}" != "" ]]; then
  autoload -U up-line-or-beginning-search
  zle -N up-line-or-beginning-search
  bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# start typing + [Down-Arrow] - fuzzy find history backward
if [[ "${terminfo[kcud1]}" != "" ]]; then
  autoload -U down-line-or-beginning-search
  zle -N down-line-or-beginning-search
  bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi


##########################
##### Plugin options #####
##########################

# Load in .zfunc
fpath+=~/.zfunc

# Spacehip theme
autoload -Uz promptinit; promptinit
ZSH_THEME="spaceship"
SPACESHIP_BATTERY_SHOW=false
SPACESHIP_BATTERY_PREFIX=""
SPACESHIP_BATTERY_SUFFIX=" "

SPACESHIP_VI_MODE_SHOW=true

##########################
##### Other programs #####
##########################

export PATH="$HOME/.local/bin:$PATH"

# Set .dircolors
if [[ -f $HOME/.dircolors ]]; then
    eval $(dircolors -b $HOME/.dircolors)
fi

# Run ssh-agent
# https://wiki.archlinux.org/index.php/SSH_keys#SSH_agents
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh/agent-thing
fi

if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.ssh/agent-thing)"
fi

# Export rustup to $PATH if it exists
if [[ -f $HOME/.cargo/env ]]; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi

# Export go/bin to $GOPATH if it exists and then export to $PATH
if [[ -d $HOME/go/bin ]]; then
    export GOPATH="$HOME/go/bin"
    export PATH="$GOPATH:$PATH"
fi

# Automatically execute direnv file
if [[ -e $(which direnv) ]]; then
    eval "$(direnv hook zsh)"
fi

# Load aliases
if [[ -f $HOME/.bash_aliases ]]; then
    source $HOME/.bash_aliases
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
