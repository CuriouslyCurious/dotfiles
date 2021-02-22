# Defined in - @ line 1
function gpom --wraps='git push origin master' --description 'alias gpom git push origin master'
  git push origin master $argv;
end
