# Defined in - @ line 1
function ll --wraps='exa -la --colour-scale' --wraps='ls -lah' --description 'alias ll ls -lah'
  ls -lah $argv;
end
