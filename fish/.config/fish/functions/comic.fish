# Defined in - @ line 1
function comic --wraps='ls -v | sxiv -i -f -Z -p -t' --description 'alias comic ls -v | sxiv -i -f -Z -p -t'
  ls -v | sxiv -i -f -Z -p -t $argv;
end
