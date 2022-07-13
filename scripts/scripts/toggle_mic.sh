#!/usr/bin/env bash

# Sound effect
sound_effect="$HOME/Downloads/beep.wav"

# Get current default source
default_source="$(pactl get-default-source)"

# Toggle mute status
pactl set-source-mute $default_source toggle

mpv --no-video $sound_effect
