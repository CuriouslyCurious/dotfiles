# Defined in - @ line 1
function pga --wraps='pass git add' --description 'alias pga pass git add'
  pass git add $argv;
end
