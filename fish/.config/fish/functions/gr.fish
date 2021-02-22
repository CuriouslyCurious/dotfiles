# Defined in - @ line 1
function gr --wraps='git restore' --description 'alias gr git restore'
  git restore $argv;
end
