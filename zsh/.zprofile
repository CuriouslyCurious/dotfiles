eval "$(dircolors ~/.dircolors/dircolors.ansi-universal)"

[[ -f ~/.zshrc ]] && . ~/.zshrc
 
if  [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
       exec startx
fi

export PATH="$HOME/.cargo/bin:$PATH"
