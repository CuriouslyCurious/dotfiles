# Defined in - @ line 1
function gt --wraps='git tag' --description 'alias gt git tag'
  git tag $argv;
end
