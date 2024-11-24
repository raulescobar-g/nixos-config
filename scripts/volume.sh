#!/usr/bin/env zsh

if [[ "$1" == "inc" ]]; then
    amixer -Mq set Master,0 5%+ unmute
elif [[ "$1" == "dec" ]]; then
    amixer -Mq set Master,0 5%- unmute
elif [[ "$1" == "mute" ]]; then
    amixer -Mq set Master toggle
fi

volume=$(amixer get Master | grep -o "[0-9]*%" | head -n 1 | sed 's/%//g')
muted=$(amixer get Master | tail -2 | grep -c '\[on\]')

if [[ "$1" == "get" ]]; then
    if [[ $muted == "0" ]]; then 
        echo 0
    else
       echo $volume 
    fi
fi

eww update volume=$volume
