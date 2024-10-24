#!/bin/bash

update() {
  WIDTH="dynamic"
  local is_yabai=$(yabai -m query --displays 2>/dev/null)
  if [ -z "${is_yabai}" ]; then
    if [[ $SID == $(aerospace list-workspaces --focused) ]]; then
      SELECTED="true"
    else
      SELECTED="false"
    fi
  fi
  if [ "$SELECTED" = "true" ]; then
    WIDTH="0" # Current space doesn't display app icons
  fi

  sketchybar --animate tanh 20 --set $NAME icon.highlight=$SELECTED label.width=$WIDTH background.drawing=$SELECTED
}

mouse_clicked() {
  if [ "$BUTTON" = "right" ]; then
    # yabai -m space --destroy $SID
    sketchybar --trigger space_change --trigger windows_on_spaces
  else
    yabai -m space --focus $SID 2>/dev/null
  fi
}

case "$SENDER" in
  "mouse.clicked") mouse_clicked
  ;;
  *) update
  ;;
esac
