#!/usr/bin/env bash

OS="$(cat /etc/*release | grep -w NAME | awk '{split($0,a,"="); print a[2]}')"

if [[ $OS == "\"Arch Linux\"" ]]
then
    pac=$(checkupdates | wc -l)
    aur=$(trizen -Qua | wc -l)

    check=$((pac + aur))
    #check=$((pac))
    if [[ "$check" != "0" ]]
    then
        echo "$pac %{F#5b5b5b}%{F-} $aur"
    fi
elif [[ $OS == "\"NixOS\"" ]]
then
    :
else
    :
fi


