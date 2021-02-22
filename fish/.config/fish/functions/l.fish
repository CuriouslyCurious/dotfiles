# Defined in - @ line 1
function l --wraps='exa -a --colour-scale' --wraps='ls -ah' --description 'alias l ls -ah'
  ls -ah $argv;
end
