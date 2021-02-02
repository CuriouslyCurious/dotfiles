#! /usr/bin/env bash

TIME=$(acpi -b | awk '{print $5}')

if [[ -n $TIME ]]; then
    echo "$TIME"
fi
