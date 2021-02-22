# https://gist.github.com/cdfa/ad5c51e30d8af1a7507d7d8ec9eb3b85

set ignore_list ".." "forkbomb"
echo $ignore_list

function import_bash_aliases \
    --description 'import bash aliases to .fish function files.'
    for a in (cat ~/.aliases | /usr/bin/grep "alias")
        set aname (echo $a | /usr/bin/sed 's/alias \(.*\)=\(\'\|\"\).*/\1/')
        set command (echo $a | /usr/bin/sed 's/alias \(.*\)=\(\'\|\"\)\(.*\)\2.*/\3/')
		# Skip stuff that should be skipped
		if string match -r "#.*" $aname > /dev/null
			continue
		else if contains $aname $ignore_list
			continue
		end

		set aname (string trim $aname)
		set command (string trim $command)

        echo "Processing alias $aname as $command"
        abbr $aname $command
    end
end
