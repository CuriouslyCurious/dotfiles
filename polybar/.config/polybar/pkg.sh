#!/bin/bash
pac=$(checkupdates | wc -l)
#aur=$(cower -u | wc -l)

#check=$((pac + aur))
check=$((pac))
if [[ "$check" != "0" ]]
then
    echo "$pac %{F#5b5b5b}%{F-} $aur"
fi
