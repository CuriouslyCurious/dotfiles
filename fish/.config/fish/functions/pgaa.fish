# Defined in - @ line 1
function pgaa --wraps='pass git add --all' --description 'alias pgaa pass git add --all'
  pass git add --all $argv;
end
