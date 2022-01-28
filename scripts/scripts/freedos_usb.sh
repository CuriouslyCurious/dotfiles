#!/usr(bin/env bash
device=$1
file=$2
dd bs=64K conv=noerror,sync status=progress if=$file of=$device
mount $1 /mnt
cd /mnt
