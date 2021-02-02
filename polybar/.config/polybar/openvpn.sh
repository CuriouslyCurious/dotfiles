#!/usr/bin/env bash

OPENVPN_PID="$(pgrep -x openvpn)"
CONNECTED="%{F#50FA7B} VPN%{F-}"
DISCONNECTED="%{F#FF5555} NO VPN%{F-}"

if [[ -n $OPENVPN_PID ]]; then
    echo $CONNECTED
else
    echo $DISCONNECTED
fi

