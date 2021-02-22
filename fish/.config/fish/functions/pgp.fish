# Defined in - @ line 1
function pgp --wraps='pass git push' --description 'alias pgp pass git push'
  pass git push $argv;
end
