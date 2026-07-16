#!/bin/bash

update() {
  WIDTH="dynamic"

  local is_aerospace=$(aerospace list-workspaces --all 2>/dev/null)
  local is_omni=$(omniwmctl query active-workspace 2>/dev/null)

  if [ "${is_aerospace}" ]; then
    if [[ $SID == $(aerospace list-workspaces --focused) ]]; then
      SELECTED="true"
    else
      SELECTED="false"
    fi
  elif [ "${is_omni}" ]; then
    # Get the actual workspace number
    if [[ $SID == $(omniwmctl query workspaces --current --fields number | jq '.result.payload.workspaces[0].number') ]]; then
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
    sketchybar --trigger space_change --trigger windows_on_spaces
  fi
}

case "$SENDER" in
"mouse.clicked")
  mouse_clicked
  ;;
*)
  update
  ;;
esac
