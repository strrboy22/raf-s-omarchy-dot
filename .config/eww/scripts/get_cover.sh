#!/bin/bash
# Get the art URL from playerctl (returns file://... or http://...)
artUrl=$(playerctl metadata mpris:artUrl 2>/dev/null)

# If no music is playing, use a default icon
if [ -z "$artUrl" ]; then
    echo "" # Return empty to show background color
    exit
fi

# If it's a local file (file://), copy it to /tmp/cover.jpg
if [[ "$artUrl" == file://* ]]; then
    cp "${artUrl#file://}" /tmp/cover.jpg
    echo "/tmp/cover.jpg"
# If it's web (Spotify/HTTP), download it
elif [[ "$artUrl" == http* ]]; then
    curl -s -o /tmp/cover.jpg "$artUrl"
    echo "/tmp/cover.jpg"
fi
