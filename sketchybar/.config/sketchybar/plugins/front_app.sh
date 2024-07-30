#!/bin/sh

# Some events send additional information specific to the event in the $INFO
# variable. E.g. the front_app_switched event sends the name of the newly
# focused application in the $INFO variable:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

if [ "$SENDER" = "front_app_switched" ]; then
  source "$HOME/.config/sketchybar/icon_map.sh"
  source "$HOME/.config/sketchybar/constants.sh"
  APP="$(yabai -m query --windows --window | jq -r '.app')"
  WINDOW_TITLE="$(yabai -m query --windows --window | jq -r '.title')"
  title="${APP} | ${WINDOW_TITLE}"
  if [[ $WINDOW_TITLE = "" ]]; then
    title="${APP}"
  else
    if [[ ${#WINDOW_TITLE} -gt 44 ]];then
      WINDOW_TITLE="$(echo "$WINDOW_TITLE" | cut -c 1-44)…"
    fi
    title="${WINDOW_TITLE}"
  fi
  __icon_map "${APP}"
  args=(
    label="$title"
    label.padding_right=4
    icon=${icon_result}
    icon.font="sketchybar-app-font:Regular:16:0"
    icon.drawing=on
    icon.color=$LABEL_ACTIVE
    icon.padding_left=32
    icon.padding_right=8
  )
  sketchybar --set "$NAME" "${args[@]}"
fi
