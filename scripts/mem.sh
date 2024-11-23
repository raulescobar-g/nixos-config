#!/usr/bin/env zsh

name="mem"

usage() {
    echo "custom ram information script"
    echo ""
    echo "Usage: $name <command>"
    echo ""
    echo "Commands:"
    echo "  used"
    echo "  free"
    echo "  total"
    echo "  available"
    echo "  help"
}

mem_used=$(free -m | grep Mem | awk '{printf "%.0f", $3*100/$2 }')
mem_free=$(free -m | grep Mem | awk '{printf "%.0f", $4*100/$2 }')
mem_available=$(free -m | grep Mem | awk '{printf "%.0f", $7*100/$2 }')
mem_total=$(free | grep Mem | awk '{printf "%s", $2}')

if [[ "$1" == "used" ]]; then
    echo $mem_used
elif [[ "$1" == "free" ]]; then
    echo $mem_free
elif [[ "$1" == "available" ]]; then
    echo $mem_available
elif [[ "$1" == "total" ]]; then
    echo $mem_total
else 
    usage
fi

exit 0
