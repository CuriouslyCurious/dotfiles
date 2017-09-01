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

# Load aliases
if [ -f $HOME/.bash_aliases ]; then
    source $HOME/.bash_aliases
fi


