# Defined in - @ line 1
function gcl --wraps='git clone --recursive -j8' --description 'alias gcl git clone --recursive -j8'
  git clone --recursive -j8 $argv;
end
