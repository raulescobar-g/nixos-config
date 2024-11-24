#!/usr/bin/env zsh

THUMBNAIL_DIR=$MUSIC_DIR/img.jpg

name="music"

usage() {
    echo "custom commands for spotify"
    echo ""
    echo "Usage: $name <command>"
    echo ""
    echo "Commands:"
    echo "  icon"
    echo "  img-path"
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
    mkdir -p $MUSIC_DIR
    #url=$(spotifycli --arturl)
    #wget -q --output-document=$THUMBNAIL_DIR $url

    echo $THUMBNAIL_DIR
else 
    usage
fi

exit 0
