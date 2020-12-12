#!/bin/bash
# https://askubuntu.com/questions/978954/how-to-change-audio-device-in-alsa-without-pulseaudio-and-need-for-restart
currentSound=$(cat /tmp/currentSound)
if [ "$currentSound" == "0" ]; then
    echo "pcm.!default { type hw card 1}" > ~/.asoundrc
    echo "1" > /tmp/currentSound
    echo "1"
else
    echo "pcm.!default { type hw card 0}" > ~/.asoundrc
    echo "0" > /tmp/currentSound
    echo "0"
fi
sudo alsactl kill rescan
