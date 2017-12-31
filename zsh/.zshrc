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
HISTSIZE=5000
SAVEHIST=10000

zstyle :compinstall filename '/home/curious/.zshrc'

autoload -Uz compinit

case "$TERM" in 
    xterm-color) color_prompt=yes;;
    xterm-256color) color_prompt=yes;;
    rxvt-unicode-256color) color_prompt=yes;;
    screen-256color) color_prompt=yes;;
esac

set bell-style none

export EDITOR=/usr/bin/nvim
export TERM=xterm-256color

setopt extendedglob

# Lower timeout delay (might cause issues)
# Default = 40
export KEYTIMEOUT=1

###################
##### Antigen #####
###################

source $HOME/.config/zsh/antigen.zsh

antigen use oh-my-zsh

# Default bundles
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found

# Syntax highlighting
antigen bundle zsh-users/zsh-syntax-highlighting

# Auto suggestions
antigen bundle zsh-users/zsh-autosuggestions

# Load the theme.
antigen theme https://github.com/denysdovhan/spaceship-zsh-theme spaceship

# Tell Antigen that you're done.
antigen apply

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

# Spacehip theme
ZSH_THEME="spaceship"
SPACESHIP_BATTERY_SHOW=false
SPACESHIP_BATTERY_PREFIX=""
SPACESHIP_BATTERY_SUFFIX=" "

SPACESHIP_VI_MODE_SHOW=true
spaceship_vi_mode_enable

##########################
##### Other programs #####
##########################

# Set .dircolors
eval $(dircolors -b $HOME/.dircolors)

# Run ssh-agent
# https://wiki.archlinux.org/index.php/SSH_keys#SSH_agents
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh/agent-thing
fi

if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.ssh/agent-thing)"
fi

# Export rustup to $PATH if it exists
if [ -f $HOME/.cargo/env ]; then
    export PATH="$HOME/.cargo/bin:$PATH" 
fi

# Export go/bin to $GOPATH if it exists and then export to $PATH
if [ -d $HOME/go/bin ]; then
    export GOPATH="$HOME/go/bin"
    export PATH="$GOPATH:$PATH"
fi

# Load aliases
if [ -f $HOME/.bash_aliases ]; then
    source $HOME/.bash_aliases
fi

