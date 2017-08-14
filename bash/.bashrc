#if [ "$TERM" != "dumb" ]; then
#[ -e "$HOME/.dircolors" ] && DIR_COLORS="$HOME/.dircolors"
#[ -e "$DIR_COLORS" ] || DIR_COLORS=""
#eval "`dircolors -b $DIR_COLORS`"
#fi
#
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
    xterm-256color) color_prompt=yes;;
    rxvt-unicode-256color) color_prompt=yes;;
    screen-256color) color_prompt=yes;;
esac

# set -g default-terminal "screen-256color"

set bell-style none

# Alias
alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias diff="diff --color=auto"
# alias i3lock="~/.i3/i3lock/lock.sh"
alias weather="curl http://wttr.in/lulea"
alias vim="nvim"
# alias i3lock="i3lock -i ~/.i3/i3lock/i3lock.png"
alias pyxeledit="wine ~/.wine/drive_c/Program\ Files/PyxelEdit/PyxelEdit.exe"
