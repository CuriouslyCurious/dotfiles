#!/usr/bin/env bash
backlight_device="intel_backlight"

program_title="$(swaymsg -t get_tree | jq -r '.. | select(.focused? == true) | .name')"
mpd="$()"
keyboard_mode="$()"
brightness=" $(cat /sys/class/backlight/$backlight_device/{actual_brightness,max_brightness} | awk 'BEGIN{ RS = ""; FS = "\n" }{printf "%.0f\n", $1/$2*100}')%"
#battery_status="$(cat /sys/class/power_supply/BAT0/status)"
battery=" $(cat /sys/class/power_supply/BAT0/capacity)%"
microphone_volume=" $(pactl get-source-volume $(pactl get-default-source) | awk '{print $5}')"
speaker_volume=" $(pactl get-sink-volume $(pactl get-default-sink) | awk '{print $5}')"
cpu_usage=" $(~/scripts/cpu_usage.sh)"
cpu_temp="$(cat /sys/class/thermal/thermal_zone1/temp | awk '{print $1/1000}')°C"
memory_usage=" $(free -h --si | awk '/^Mem/{print $3"/"$2}')"
network="直 $(wpa_cli status | awk -F= '/^ssid/{print $2}')"
vpn=""
date=" $(date '+%F %H:%M')"
unread_emails=""
#num_packages="$(paru -Qua)"

echo "$program_title  $mpd  $keyboard_mod $cpu_usage $cpu_temp  $memory_usage  $battery  $brightness  $microphone_volume  $speaker_volume  $network  $date"
