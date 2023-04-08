# Enable vi mode
fish_vi_key_bindings

set GPG_TTY (tty)

# Ctrl-backspace working as it should
#bind \e\[3\;5~ kill-word
bind \cH backward-kill-path-component
bind -M insert \cH backward-kill-word

# Line jump stuff
bind H beginning-of-line
bind L end-of-line

# Load zoxide
zoxide init --cmd cd fish | source

# Load prompt
starship init fish | source

env ~/.profile

# Autostart X at login
#if status is-login
#    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
#        exec startx -- -keeptty
#    end
#end
