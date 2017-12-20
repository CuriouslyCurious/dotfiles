#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

#polybar top &
#polybar top-right &

MONITOR=DP-1 polybar main &
MONITOR=HDMI-1 polybar secondary &
MONITOR=DVI-D-1 polybar tertiary &

echo "Bars launched..."
