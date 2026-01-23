#!/bin/bash

# =========================
# Paths
# =========================
SDDM_DIR="/usr/share/sddm/themes/sddm-astronaut-theme"
CONF_DIR="$SDDM_DIR/Themes"
WALL_DIR="$SDDM_DIR/Backgrounds"
CACHE="$HOME/.cache/sddm-wallpapers"

mkdir -p "$CACHE"

# =========================
# Generate thumbnails (static only)
# =========================
for conf in "$CONF_DIR"/*.conf; do
    img=$SDDM_DIR/$(grep '^Background=' $conf | cut -d'"' -f2)
    [ -e "$img" ] || continue

    base="$(basename "$img")"
    thumb="$CACHE/${base%.*}.png"

    if [ ! -f "$thumb" ]; then
        if [ "${img##*.}" == "gif" -o "${img##*.}" == "mp4" ]  ; then
            magick ${img}[0] -resize 200x200 -gravity center -extent 200x200 -quality 40 $thumb
        else
            magick "$img" -resize 200x200 -quality 40 "$thumb"
        fi
    fi
done

# =========================
# Rofi menu (static + GIF)
# =========================
choice=$((
    for conf in "$CONF_DIR"/*.conf; do
        img=$SDDM_DIR/$(grep '^Background=' $conf | cut -d'"' -f2)
        [ -e "$img" ] || continue
        base="$(basename "$img")"
        cache_img="${base%.*}.png"
        echo -e "$base\x00icon\x1f$CACHE/$cache_img"
    done
) | rofi -dmenu \
        -theme ~/.config/rofi/wallpaper.rasi \
        -p "Greeter screen")

[ -z "$choice" ] && exit

IMG_PATH="$WALL_DIR/$choice"
IMG_NAME="${choice%.*}"

# =========================
# Wallpaper change (SINGLE GROW)
# =========================

CONF_NAME="${IMG_NAME%.*}.conf"
sed -i -E "s#(ConfigFile=Themes/).*#\1$CONF_NAME#" $SDDM_DIR/metadata.desktop

# =========================
# Notify
# =========================

(
    sleep 1.8
    notify-send -i "$IMG_PATH" "Wallpaper Changed" "$IMG_NAME"
) &

# =========================
# Safe reloads
# =========================

# Close rofi cleanly
pkill rofi
