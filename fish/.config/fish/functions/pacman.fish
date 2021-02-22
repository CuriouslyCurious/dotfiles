# Defined in - @ line 1
function pacman --wraps='sudo pacman' --description 'alias pacman sudo pacman'
  sudo pacman $argv;
end
