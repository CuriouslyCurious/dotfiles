#!/bin/bash
bat=$(acpi -a)
if [ "$bat" = "Adapter 0: on-line" ]; then
    /home/curious/.config/i3/lock.sh
else
    systemctl suspend
fi
