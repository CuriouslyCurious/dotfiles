# Ugly hack to update last_dir on dir change,
function __pwd_hook --on-variable PWD --description 'Updates ~/.last_dir on cd change'
	exa -a
	echo $PWD > ~/.last_dir
end


