# Defined in - @ line 1
function hf --wraps=hyperfine --description 'alias hf hyperfine'
  hyperfine  $argv;
end
