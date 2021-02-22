# Defined in - @ line 1
function la --wraps='exa -la --colour-scale' --wraps='ls -lah' --description 'alias la ls -lah'
  ls -lah $argv;
end
