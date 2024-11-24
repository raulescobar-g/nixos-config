#!/usr/bin/env zsh

THUMBNAIL_DIR=$MUSIC_DIR/img

name="music"

usage() {
    echo "custom commands for spotify"
    echo ""
    echo "Usage: $name <command>"
    echo ""
    echo "Commands:"
    echo "  icon"
    echo "  img-path"
    echo "  download-img"
    echo "  help"
}



if [[ "$1" == "icon" ]]; then
    STATUS=$(spotifycli --playbackstatus)
    if [[ $STATUS == "▮▮" ]]; then
        echo ""
    else
        echo ""
    fi
elif [[ "$1" == "img-path" ]]; then
    echo $THUMBNAIL_DIR
elif [[ "$1" == "download-img" ]]; then
    mkdir -p $MUSIC_DIR
    url=$(spotifycli --arturl)
    wget --output-document=$THUMBNAIL_DIR $url
else 
    usage
fi

exit 0
