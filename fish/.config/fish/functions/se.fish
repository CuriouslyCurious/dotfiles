# Defined in - @ line 1
function se --wraps=nvim --description 'alias se sudo nvim'
  sudo nvim $argv;
end
