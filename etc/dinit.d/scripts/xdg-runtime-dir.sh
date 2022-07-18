#!/usr/bin/env bash
# TODO: Loop over /home dirs instead

USER="curious"
GROUP="curious"

XDG_RUNTIME_DIR="/run/user/`id -u $USER`"
if [ $? -ne 0 ]; then
    echo "No such user: '$USER'"
    exit 1
fi

# Delete existing dir, then create a new one with
# correct permissions
rm -rf $XDG_RUNTIME_DIR
mkdir -p $XDG_RUNTIME_DIR -m 0700
chown $USER:$GROUP $XDG_RUNTIME_DIR
