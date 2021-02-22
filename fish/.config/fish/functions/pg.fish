# Defined in - @ line 1
function pg --wraps='pass git' --description 'alias pg pass git'
  pass git $argv;
end
