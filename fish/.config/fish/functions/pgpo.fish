# Defined in - @ line 1
function pgpo --wraps='pass git push origin' --description 'alias pgpo pass git push origin'
  pass git push origin $argv;
end
