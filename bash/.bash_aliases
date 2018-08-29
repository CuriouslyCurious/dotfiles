# Aliases #
# Colors
alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias diff="diff --color=auto"
# Configs
alias cvim="vim $HOME/.vimrc"
# Editor
alias e="$EDITOR"
# vim
alias vim="vim"
alias vi="vim"
# Git
alias ga="git add"
alias gaa="git add --all"
alias gc="git commit -v"
alias gca="git commit -av"
alias gp="git push"
alias gpom="git push origin master"
alias gpo="git push origin"
alias gb="git branch"
alias gs="git status"
alias gl="git log"
alias gfm="git pull"
alias gd="git diff"
alias gt="git tag"
alias gcl="git clone --recursive -j8"
alias gsu="git submodule update --remote --merge"
# ls
alias l="ls -lah"
alias la="ls -lah"
# Pacman
alias pacman="sudo pacman"
alias Syu="sudo pacman -Syu"
# Power
alias hibernate="systemctl hibernate"
alias suspend="systemctl suspend"
# taskwarrior
alias t="task"
alias tw="task"
# pass
alias p="pass"
alias pg="pass git"
alias pga="pass git add"
alias pgaa="pass git add --all"
alias pgc="pass git commic -v"
alias pgca="pass git commic -av"
alias pgp="pass git push"
alias pgpom="pass git push origin master"
alias pgpo="pass git push origin"
alias pgfm="pass git pull"
# Java is dumb
alias syncsim="wmname LG3D && exec $HOME/scripts/syncsim"
# Misc
alias dude="du -h --exclude=./yesterday | sort -h | grep -E \"^[0-9]+(\.|,)?[0-9]*M\""
alias weather="curl http://wttr.in/lulea"
alias c="clear"
alias se="sudoedit"
alias x="exit"
alias top="htop"
# Passes all files in current directory to sxiv
function _comic() {find $@ -type f -exec file {} \; | awk -F: '{if ($2 ~/image/) print $1}' | sxiv -i -f -Z -p -t ;}
alias comic="_comic"


