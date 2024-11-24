#!/usr/bin/env zsh

if [[ "$1" == "inc" ]]; then
    amixer -Mq set Master,0 5%+ unmute
elif [[ "$1" == "dec" ]]; then
    amixer -Mq set Master,0 5%- unmute
fi

volume=$(amixer get Master | grep -o "[0-9]*%" | head -n 1 | sed 's/%//g')
if [[ "$1" == "get" ]]; then
    echo $volume
fi

eww update volume=$volume
