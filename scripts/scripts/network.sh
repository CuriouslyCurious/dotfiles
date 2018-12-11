#!/usr/bin/env bash
INTERFACE="wlp3s0"
sudo wpa_supplicant -B -i $INTERFACE -c /etc/wpa_supplicant/wpa_supplicant.conf
sudo dhcpcd $INTERFACE
