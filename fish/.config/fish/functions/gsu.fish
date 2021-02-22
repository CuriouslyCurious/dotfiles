# Defined in - @ line 1
function gsu --wraps='git submodule update --remote --merge' --description 'alias gsu git submodule update --remote --merge'
  git submodule update --remote --merge $argv;
end
