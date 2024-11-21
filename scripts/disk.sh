#!/usr/bin/env zsh

disk_used=$(df -kh | tail -n1 | awk '{print $5}' | sed 's/%//g')

if [[ "$1" == "used" ]]; then
    echo $disk_used
elif [[ "$1" == "h" ]]; then
    echo "h"
elif [[ "$1" == "t" ]]; then
    echo "t"
fi
