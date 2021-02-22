# Defined in - @ line 1
function pgpom --wraps='pass git push origin master' --description 'alias pgpom pass git push origin master'
  pass git push origin master $argv;
end
