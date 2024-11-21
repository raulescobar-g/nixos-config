#!/usr/bin/env zsh

connected=$(ping -q -w 1 -c 1 `ip r | grep default | cut -d ' ' -f 3` > /dev/null && echo 1 || echo 0)
essid=$(nmcli c | grep wlp5s0 | awk '{print ($1)}')
strength=$(awk 'NR==3 {printf("%.0f\n",$3*10/7)}' /proc/net/wireless)


if [[ "$1" == "connected" ]]; then
    echo $connected
elif [[ "$1" == "strength" ]]; then
    echo $strength
elif [[ "$1" == "essid" ]]; then
    echo $essid
fi
