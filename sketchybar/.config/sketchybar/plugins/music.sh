#!/bin/sh

source "$HOME/.config/sketchybar/constants.sh"

sleep 1
APP_STATE=$(pgrep -x Music)
if [[ ! $APP_STATE ]]; then 
    sketchybar  --animate tanh 20 \
      --set music drawing=off \
      --set music.artwork drawing=off \
      --set notch popup.height=48 \
      --animate tanh 10 \
      --set notch.calendar y_offset=-4 \
                           padding_left=16 \
                           width=dynamic \
                           icon.drawing=true
    exit 0
fi
STATE=$(osascript -e 'tell application "Music" to set playerState to (get player state) as text')

if [[ $STATE == "stopped" ]]; then
    sketchybar  --animate tanh 20 \
      --set music drawing=off \
      --set music.artwork drawing=off \
      --set notch popup.height=48 \
      --animate tanh 10 \
      --set notch.calendar y_offset=-4 \
                           padding_left=16 \
                           width=dynamic \
                           icon.drawing=true
    exit 0
fi

if [[ $STATE == "paused" ]]; then
    icon=" "
fi

if [[ $STATE == "playing" ]]; then
    icon=" "
fi

title=$(osascript -e 'tell application "Music" to get name of current track')
artist=$(osascript -e 'tell application "Music" to get artist of current track')

ARTWORK_LOCATION="$HOME/album_art.tiff"
if [[ $STATE == "playing" ]]; then

  CACHE_LOCATION="$HOME/Library/Caches/com.apple.Music/fsCachedData"
  RAW_URL=$(find "$CACHE_LOCATION" -type f -mmin -128 -print0 | xargs -0 ls -t 2>/dev/null | head -n 1 | xargs -I {} cat "{}" | jq -r '.. | objects | select(has("artwork")) | .artwork.url' | head -n 1)

  if [ -z "$RAW_URL" ] || [ "$RAW_URL" == "null" ]; then
    # --- Do nothing
    exit 0
  fi
  ARTWORK_SIZE=720
  FINAL_URL=$(echo "$RAW_URL" | sed "s/{w}/$ARTWORK_SIZE/g; s/{h}/$ARTWORK_SIZE/g")
  curl -s "$FINAL_URL" -o "$ARTWORK_LOCATION"

fi


if [[ ${#title} -gt 25 ]]; then
  title=$(printf "$(echo $title | cut -c 1-25)…")
fi

if [[ ${#artist} -gt 25 ]]; then
  artist=$(printf "$(echo $artist | cut -c 1-25)…")
fi

label="${artist} - ${title}"
label_real_width=$((${#label} * 7))
label_width="dynamic"
if [[ $label_real_width -lt 128 ]]; then
  label_width=128
fi

music_args=(
  icon="$icon"
  icon.font="$FONT_ICON:Bold:15.0"
  icon.y_offset=0
  icon.padding_right=8
  label="${label}"
  width=$label_width
  drawing=true
)

music_artwork_args=(
  drawing=true
  label.drawing=false
  icon.drawing=false
  background.corner_radius=0
  background.color="$TRANSPARENT"
  background.image.string="$ARTWORK_LOCATION"
  background.image.corner_radius=4
  background.image.y_offset=-2
)

sketchybar -m --set music "${music_args[@]}"
sketchybar -m --set music.artwork "${music_artwork_args[@]}"

# When there is a notch
sketchybar --animate tanh 20 \
           --set notch popup.height=60 \
           --animate tanh 10 \
           --set notch.calendar y_offset=8 \
                                padding_left=0 \
                                width=0 \
                                icon.drawing=false \
