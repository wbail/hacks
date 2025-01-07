#!/bin/bash

if [[ -z $1 ]];
then 
    echo "No parameter passed."
    exit 1
fi

# Get the parameter
input_string="$1"

if [[ "$input_string" == *"playlist"* ]]; then
    echo "The parameter contains the string 'playlist'."
    echo "Parameter passed = $input_string"

    yt-dlp \
    --write-description \
    --write-info-json \
    --write-thumbnail \
    --progress \
    --write-auto-subs \
    --sub-format srt \
    -f bestvideo*+bestaudio/best \
    -o /mnt/c/Users/Guilherme\ Bail/Downloads/"%(uploader)s/%(playlist)s/%(playlist_index)s - %(title)s/%(playlist_index)s - %(title)s.%(ext)s" \
    $input_string

else
    echo "Parameter passed = $input_string"

    yt-dlp \
    --write-description \
    --write-info-json \
    --write-thumbnail \
    --progress \
    --write-auto-subs \
    --sub-format srt \
    -f bestvideo*+bestaudio/best \
    -o /mnt/c/Users/Guilherme\ Bail/Downloads/"%(uploader)s/%(title)s/%(title)s [%(id)s].%(ext)s" \
    $input_string

fi

exit 1
