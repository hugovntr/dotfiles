#!/bin/sh

# Some events send additional information specific to the event in the $INFO
# variable. E.g. the front_app_switched event sends the name of the newly
# focused application in the $INFO variable:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

if [ "$SENDER" = "front_app_switched" ]; then
  source "$HOME/.config/sketchybar/icon_map.sh"
  source "$HOME/.config/sketchybar/constants.sh"
  __icon_map "${INFO}"
  args=(
    label="$INFO"
    icon=${icon_result}
    icon.font="sketchybar-app-font:Regular:16:0"
    icon.drawing=on
    icon.color=$LABEL_ACTIVE
    icon.padding_left=32
    icon.padding_right=8
  )
  sketchybar --set "$NAME" "${args[@]}"
fi
