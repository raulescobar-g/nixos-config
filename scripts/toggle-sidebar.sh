#!/bin/env zsh

WIDGET="side-bar"
LOCK_FILE="${LOCK_DIR}/${WIDGET}.lock"

run() {
    eww open ${WIDGET} 
}

close() {
    eww close ${WIDGET}
}

mkdir -p ${LOCK_DIR}

if [[ ! -f "$LOCK_FILE" ]]; then
    touch "$LOCK_FILE" && run && echo "opened ${WIDGET}"
else
    close && rm "$LOCK_FILE" && echo "closed ${WIDGET}"
fi
