#!/bin/bash

CPU=(`procs --no-header --only cpu | awk '{print $1 * 10}'`)
TOTAL=0
NUM_CPUS=4

for VALUE in "${CPU[@]}"; do
    let "TOTAL=$TOTAL+$VALUE"
done

echo -e "$(( $TOTAL/10/$NUM_CPUS ))%"
