#!/usr/bin/env zsh

mem_free=$(free -m | grep Mem | awk '{printf "%.0f\n", $3*100/$2 }')

if [[ "$1" == "free" ]]; then
    echo $mem_free
elif [[ "$1" == "h" ]]; then
    echo "h"
elif [[ "$1" == "t" ]]; then
    echo "t"
fi
