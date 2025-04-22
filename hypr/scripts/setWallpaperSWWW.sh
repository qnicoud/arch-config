#!/bin/bash

WALLPAPER_FOLDER="${HOME}/.local/share/wallpapers"
CURR_WALLPAPER_NAME="${WALLPAPER_FOLDER}/curr_wallpaper"

if ! pgrep swww-daemon > /dev/null 2>&1 ; then
    echo "swww-daemon not running. Starting ..."
    swww-daemon &
    echo "Done ?"
fi

if [ ! -d ${WALLPAPER_FOLDER} ] ; then
    echo "The wallpaper folder does not exist. Exiting ..."
    exit 1
fi

rm "${CURR_WALLPAPER_NAME}"
RANDOM="$$$(date +%s)"
WALLPAPERS=($(find ${WALLPAPER_FOLDER}/* -maxdepth 1))

CURR_SELECTION="${WALLPAPERS[$RANDOM % ${#WALLPAPERS[@]}]}"
#magick "${CURR_SELECTION}" -resize 2560x1440 "${CURR_WALLPAPER_NAME}"
cp "${CURR_SELECTION}" "${CURR_WALLPAPER_NAME}"

swww img    -o "DP-2" "${CURR_WALLPAPER_NAME}" -t any --transition-duration 2
swww clear  -o "DP-1" 111111

