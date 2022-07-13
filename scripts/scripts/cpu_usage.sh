#!/bin/bash
# by Paul Colby (http://colby.id.au), no rights reserved ;)

CPU=(`cat /proc/stat | grep '^cpu '`) # Get the total CPU statistics.
unset CPU[0]                          # Discard the "cpu" prefix.
IDLE=${CPU[4]}                        # Get the idle CPU time.

# Calculate the total CPU time.
TOTAL=0

for VALUE in "${CPU[@]:0:4}"; do
let "TOTAL=$TOTAL+$VALUE"
done

# Calculate the CPU usage since we last checked.
let "DIFF_USAGE=(1000*($TOTAL-$IDLE)/$TOTAL+5)/10"
echo -e "$DIFF_USAGE%"
