# Defined in - @ line 1
function cvim --wraps='vim $HOME/.vimrc' --description 'alias cvim vim $HOME/.vimrc'
  vim $HOME/.vimrc $argv;
end
