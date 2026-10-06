#!/bin/bash

update() {
  WIDTH="dynamic"

  local is_aerospace=$(aerospace list-workspaces --all 2>/dev/null)

  if [ "${is_aerospace}" ]; then
    if [[ $SID == $(aerospace list-workspaces --focused) ]]; then
      SELECTED="true"
    else
      SELECTED="false"
    fi
  else
    # Query fresh on every event: a cache would show stale highlights,
    # since all space items refresh on the same event burst.
    num=$(omniwmctl query active-workspace 2>/dev/null | jq -r '.result.payload.workspace.number' 2>/dev/null)
    [ "$num" = "null" ] && num=""
    if [ -n "$num" ] && [[ $SID == "$num" ]]; then
      SELECTED="true"
    else
      SELECTED="false"
    fi
  fi

  if [ "$SELECTED" = "true" ]; then
    WIDTH="0" # Current space doesn't display app icons
  fi

  sketchybar --animate tanh 10 --set $NAME icon.highlight=$SELECTED label.width=$WIDTH background.drawing=$SELECTED
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
