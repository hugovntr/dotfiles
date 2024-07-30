#!/bin/sh

source "$HOME/.config/sketchybar/constants.sh"

APP_STATE=$(pgrep -x Music)
if [[ ! $APP_STATE ]]; then 
    sketchybar -m --set music drawing=off
    exit 0
fi

STATE=$(echo $INFO | jq -r '.state')
title=$(echo $INFO | jq -r '.title')
artist=$(echo $INFO | jq -r '.artist')
if [[ $STATE == "stopped" ]]; then
    sketchybar --set music drawing=off
    exit 0
fi

if [[ $STATE == "paused" ]]; then
    icon=" "
fi

if [[ $STATE == "playing" ]]; then
    icon=" "
fi

if [[ ${#title} -gt 25 ]]; then
TITLE=$(printf "$(echo $title | cut -c 1-25)…")
fi

if [[ ${#artist} -gt 25 ]]; then
ARTIST=$(printf "$(echo $artist | cut -c 1-25)…")
fi

args=(
  icon="$icon"
  icon.font="$FONT:Bold:14.0"
  icon.color="$WHITE"
  icon.padding_right=4
  label="${title} — ${artist}"
  label.font="$FONT:Bold:12.0"
  drawing=on
)

sketchybar -m --set music "${args[@]}"
