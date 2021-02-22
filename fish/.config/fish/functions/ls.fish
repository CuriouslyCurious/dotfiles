# Defined in - @ line 1
function ls --wraps='exa -a --colour-scale' --wraps='ls --color=auto' --description 'alias ls ls --color=auto'
 command ls --color=auto $argv;
end
