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

if [[ $STATE == "playing" ]]; then
    osascript "$(pwd)/plugins/music.applescript"
fi
ARTWORK_LOCATION="~/album_art.tiff"


if [[ ${#title} -gt 25 ]]; then
  title=$(printf "$(echo $title | cut -c 1-25)…")
fi

if [[ ${#artist} -gt 25 ]]; then
  artist=$(printf "$(echo $artist | cut -c 1-25)…")
fi

music_args=(
  icon="$icon"
  icon.font="$FONT_ICON:Bold:15.0"
  icon.y_offset=0
  icon.padding_right=8
  label="${artist} — ${title}"
  drawing=true
)

music_artwork_args=(
  drawing=true
  label.drawing=false
  icon.drawing=false
  background.color="$TRANSPARENT"
  background.image="$ARTWORK_LOCATION"
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
