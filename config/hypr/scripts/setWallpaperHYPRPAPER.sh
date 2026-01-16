#!/bin/bash

hyprctl hyprpaper unload all
# Sets a random wallpaper with hyprpaper

wallpapers=($(ls -d $HOME/.local/share/wallpapers/*.png))
wallpapersi+=($(ls -d $HOME/.local/share/wallpapers/*.jpg))
#wallpapers+=($(ls -d /usr/share/hyprland/wall*))

wall=${wallpapers[ $RANDOM % ${#wallpapers[@]} ]}

hyprctl hyprpaper preload $wall
hyprctl hyprpaper wallpaper ,$wall
