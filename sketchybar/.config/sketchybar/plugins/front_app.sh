#!/bin/sh

# Some events send additional information specific to the event in the $INFO
# variable. E.g. the front_app_switched event sends the name of the newly
# focused application in the $INFO variable:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

if [ "$SENDER" = "front_app_switched" ]; then
  source "$HOME/.config/sketchybar/icon_map.sh"
  source "$HOME/.config/sketchybar/constants.sh"

  is_aerospace=$(aerospace list-workspaces --all 2>/dev/null)
  is_omni=$(omniwmctl query active-workspace 2>/dev/null)

  cmd="{\"app\": \"\", \"title\": \"\"}"

  if [ "${is_aerospace}" ]; then
    app=$(aerospace list-windows --focused --format '%{app-name}' | jq -R '.')
    title=$(aerospace list-windows --focused --format '%{window-title}' | jq -R '.')
    cmd="{\"app\": ${app}, \"title\": ${title}}"
  elif [ "${is_omni}" ]; then
    app=$(omniwmctl query focused-window | jq '.result.payload.window.app.name')
    cmd="{\"app\": ${app}, \"title\": \"\"}"
  fi


  APP="$(echo $cmd | jq -r '.app')"
  if [[ $APP = "null" ]]; then
    args=(
    icon.drawing=false
    label.drawing=false
  )
    sketchybar --set "$NAME" "${args[@]}"
    exit
  else
    WINDOW_TITLE="$(echo $cmd | jq -r '.title')"
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
    icon=${icon_result}
    icon.drawing=true
    label.drawing=true
  )
    sketchybar --set "$NAME" "${args[@]}"
  fi
fi
