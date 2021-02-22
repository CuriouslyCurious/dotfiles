# Defined in - @ line 1
function dude --wraps=du\ -h\ --exclude=./yesterday\ 2\>/dev/null\ \|\ sort\ -h\ \|\ grep\ -e\ \\\"\^\[0-9\]+\(\\.\|,\)\?\[0-9\]\*M\\\" --description alias\ dude\ du\ -h\ --exclude=./yesterday\ 2\>/dev/null\ \|\ sort\ -h\ \|\ grep\ -e\ \\\"\^\[0-9\]+\(\\.\|,\)\?\[0-9\]\*M\\\"
  du -h --exclude=./yesterday 2>/dev/null | sort -h | grep -e \"^[0-9]+(\.|,)?[0-9]*M\" $argv;
end
