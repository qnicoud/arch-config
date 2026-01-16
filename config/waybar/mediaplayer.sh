#!/bin/sh
player_status=$(playerctl status 2> /dev/null)
artist=$(playerctl -p spotify_player metadata xesam:artist)
title=$(playerctl -p spotify_player metadata xesam:title)
music_info="${artist} - ${title}"

if [ -z $status ] ; then
    exit
fi

if [ "$player_status" = "Playing" ]; then
    echo "{\"class\": \"playing\", \"text\": \"$music_info\"}"  
    pkill -RTMIN+5 waybar
    exit
elif [ "$player_status" = "Paused" ]; then
    echo "{\"class\": \"paused\", \"text\": \"$music_info\"}" 
    pkill -RTMIN+5 waybar
    exit
fi
