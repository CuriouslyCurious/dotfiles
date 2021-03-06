#!/bin/sh
# https://github.com/jaagr/polybar/issues/555

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
DISPLAY1="$(xrandr -q | grep 'DisplayPort-0\|DP-1\|LVDS1\|LVDS-1\|VGA-1' | cut -d ' ' -f1 | head -n 1)"
[[ ! -z "$DISPLAY1" ]] && MONITOR="$DISPLAY1" polybar main & 2>/dev/null

DISPLAY2="$(xrandr -q | grep 'HDMI-0\|HDMI-1\|DVI-I-1' | cut -d ' ' -f1)"
[[ ! -z $DISPLAY2 ]] && MONITOR=$DISPLAY2 polybar main & 2>/dev/null

DISPLA3="$(xrandr -q | grep 'DVI-0\|DVI-D-1' | cut -d ' ' -f1)"
[[ ! -z $DISPLAY3 ]] && MONITOR=$DISPLAY3 polybar main & 2>/dev/null
echo "Bars launched..."

