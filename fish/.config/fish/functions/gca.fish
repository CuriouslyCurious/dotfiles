# Defined in - @ line 1
function gca --wraps='git commit -av' --description 'alias gca git commit -av'
  git commit -av $argv;
end
