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

# Alias
alias ls="ls --color=auto"
alias i3lock="~/.i3/i3lock/lock.sh"
alias weather="curl http://wttr.in/lulea"
