#!/usr/bin/env zsh


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
    url=$(spotifycli --arturl)
    thumbail_dir=$MUSIC_DIR/$(date +%s).jpg
    wget -q --output-document=$thumbnail_dir $url

    echo $thumbnail_dir
else 
    usage
fi

exit 0
