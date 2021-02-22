# Defined in - @ line 1
function cat --wraps='bat -n' --description 'alias cat bat -n'
  bat -n $argv;
end
