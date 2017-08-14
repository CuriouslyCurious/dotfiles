# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=10000
#bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/curious/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
case "$TERM" in 
    xterm-color) color_prompt=yes;;
    xterm-256color) color_prompt=yes;;
    rxvt-unicode-256color) color_prompt=yes;;
    screen-256color) color_prompt=yes;;
esac

set bell-style none

# -- Antigen --
source $HOME/.config/zsh/antigen.zsh

antigen use oh-my-zsh
# Default bundles
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
#antigen theme robbyrussell
#antigen theme https://github.com/caiogondim/bullet-train-oh-my-zsh-theme bullet-train
#antigen theme https://github.com/halfo/lambda-mod-zsh-theme/ lambda-mod
antigen theme https://github.com/denysdovhan/spaceship-zsh-theme spaceship

# Tell Antigen that you're done.
antigen apply
# -- End Antigen --

export EDITOR=/usr/bin/nvim

# Functions #
function chpwd() {
    emulate -L zsh
    ls -a
}

# Aliases #
# Colors
alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias diff="diff --color=auto"
# ls
alias l="ls -la"
alias la="ls -la"
# Git
alias ga="git add"
alias gaa="git add -all"
alias gc="git commit -v"
alias gca="git commit -av"
alias gp="git push"
alias gpom="git push origin master"
alias gb="git branch"
alias gs="git status"
# Misc
alias weather="curl http://wttr.in/lulea"
alias vim="nvim"
alias c="clear"
alias se="sudoedit"
alias x="exit"
alias Syu="sudo pacman -Syu"