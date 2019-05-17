#!/usr/bin/env bash 
# Your friendly reminder that pulseaudio sucks

# https://askubuntu.com/questions/71863/how-to-change-pulseaudio-sink-with-pacmd-set-default-sink-during-playback#72076
# Bash port of https://gist.github.com/uriel1998/1791270
# 
# This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 
# Unported License. To view a copy of this license, visit 
# http://creativecommons.org/licenses/by-sa/3.0/.
#
# Forked/derived from original by Jasper Van der Jeugt (jaspervdj);
# large chunks rewritten by Steven Saus (uriel1998)
# This is designed to set your pulseaudio volume settings, muting, and
# default sink from the command line.  It will even switch currently
# running streams to the new sink when you switch it!
# Usage will be largely for folks who are using keybinds for volume, etc.
# Originally wrote this to work with ALSA cards - that's what I have.
# (see line 46) but the code at line 45 *should* work for anything
# that's set up as a device in PulseAudio.  This is written to work
# with the version of PulseAudio I have on my system - 0.9.22.
# By perusing the online PulseAudio documentation, it looks like this
# *should* still work just fine for later versions.  Please ping me one
# way or another so I can properly document/fix it...

DEFAULT_SINK="alsa_input.pci-0000_00_14.2.analog-stereo"
SECONDARY_SINK="alsa_output.usb-FiiO_DigiHug_USB_Audio-01.analog-stereo"

DEFAULT_SOURCE="alsa_input.pci-0000_00_14.2.analog-stereo"
SECONDARY_SOURCE=""

# Create  an array of available sinks
SINKS=("$(pactl list short sinks | awk '{print $2}')")

# Create an array of available sources
SOURCES=("$(pactl list short sources | awk '{print $2}')")

MUTE=false
CURRENT_SINK="$(pactl info | grep 'Default Sink' | awk '{print $3}')"

# Toggles mute on the given sink
function mute {
    sink=$1
    if $MUTE; then
        `pacmd set-sink-mute $sink no`
        MUTE=false
    else
        `pacmd set-sink-mute $sink yes`
        MUTE=true
    fi
}

function swap_sink {
    if [[ -n $DEFAULT_SINK ]] && [[ -n $SECONDARY_SINK ]]; then
        echo "Current: $CURRENT_SINK"
        echo "Default: $DEFAULT_SINK"
        echo "Secondary: $SECONDARY_SINK"
        if [ $CURRENT_SINK == $DEFAULT_SINK ]; then
            CURRENT_SINK=$SECONDARY_SINK
        elif [ $CURRENT_SINK == $SECONDARY_SINK ]; then
            CURRENT_SINK=$DEFAULT_SINK
        else
            echo "ERROR: The current sink '$CURRENT_SINK' does not match any of the given sinks."
            exit -1
        fi

        echo "Current: $CURRENT_SINK"
        echo "Default: $DEFAULT_SINK"
        echo "Secondary: $SECONDARY_SINK"
        echo "Setting default sink to: $CURRENT_SINK"
        pacmd set-default-sink $CURRENT_SINK

        
        indexes=("$(pacmd list-sink-inputs | grep 'index' | awk '{print $2}')")
        echo "Moving sink inputs to new default..."
        for index in ${indexes[*]}; do
            pacmd move-sink-input $index $CURRENT_SINK
        done
        
        echo "Done."

    else
        echo "ERROR: Sink variables are not properly set."
        exit -1
    fi
}

swap_sink
