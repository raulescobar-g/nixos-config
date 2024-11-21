#!/usr/bin/env zsh

cpu_avg=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')

if [[ "$1" == "avg" ]]; then
    echo $cpu_avg 
elif [[ "$1" == "h" ]]; then
    echo "h"
elif [[ "$1" == "t" ]]; then
    echo "t"
fi
