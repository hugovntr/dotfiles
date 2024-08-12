#!/bin/bash

# Yabai Icons
YABAI_STACK=
YABAI_FULLSCREEN_ZOOM=󰊓
YABAI_PARENT_ZOOM=
YABAI_FLOAT=󱂬
YABAI_GRID=󰝘

window_state() {

  source "$HOME/.config/sketchybar/constants.sh"

  WINDOW="$(yabai -m query --windows --window 2>/dev/null)"
  if [ -z "${WINDOW}" ]; then
    exit 0;
  fi
  CURRENT=$(echo "$WINDOW" | jq '.["stack-index"]')

  args=()
  if [[ $CURRENT -gt 0 ]]; then
    LAST=$(yabai -m query --windows --window stack.last | jq '.["stack-index"]')
    args+=(--set $NAME icon=$YABAI_STACK icon.color=$RED label.drawing=on label=$(printf "[%s/%s]" "$CURRENT" "$LAST"))

  else 
    args+=(--set $NAME label.drawing=off)
    case "$(echo "$WINDOW" | jq '.["is-floating"]')" in
      "false")
        if [ "$(echo "$WINDOW" | jq '.["has-fullscreen-zoom"]')" = "true" ]; then
          args+=(--set $NAME icon=$YABAI_FULLSCREEN_ZOOM icon.color=$GREEN)
        elif [ "$(echo "$WINDOW" | jq '.["has-parent-zoom"]')" = "true" ]; then
          args+=(--set $NAME icon=$YABAI_PARENT_ZOOM icon.color=$BLUE)
        else
          args+=(--set $NAME icon=$YABAI_GRID icon.color=$BRAND label="Stack")
        fi
        ;;
      "true")
        args+=(--set $NAME icon=$YABAI_FLOAT icon.color=$MAUVE)
        ;;
    esac
  fi

  sketchybar -m "${args[@]}"
}

windows_on_spaces () {
  CURRENT_SPACES="$(yabai -m query --displays 2>/dev/null | jq -r '.[].spaces | @sh')"
  if [ -z "${CURRENT_SPACES}" ]; then
    CURRENT_SPACES="$(aerospace list-workspaces --all | tr '\n' ' ')"
  fi
  source "$HOME/.config/sketchybar/icon_map.sh"

  args=()
  while read -r line
  do
    for space in $line
    do
      icon_strip=""
      space_args=(--set space.$space)
      cmd=$(yabai -m query --windows --space $space 2>/dev/null)
      if [ -z "${cmd}" ]; then
        cmd=$(aerospace list-windows --workspace $space --format '[{"app": "%{app-name}"}]')
      fi
      apps=$(echo $cmd | jq -r ".[].app")
      if [ "$apps" != "" ]; then
        while IFS= read -r app; do
          __icon_map "${app}"
          icon_strip+=" ${icon_result}"
        done <<< "$apps"
        space_args+=(label="$icon_strip" label.drawing=true)
      else
        space_args+=(label.drawing=false)
      fi
      args+=("${space_args[@]}")
    done
  done <<< "$CURRENT_SPACES"

  sketchybar -m "${args[@]}"
}

# mouse_clicked() {
#   yabai -m window --toggle float
#   window_state
# }

case "$SENDER" in
  # "mouse.clicked") mouse_clicked
  # ;;
  "forced") 
    windows_on_spaces
    exit 0
  ;;
  "window_focus") window_state 
  ;;
  "windows_on_spaces") windows_on_spaces
  ;;
esac
