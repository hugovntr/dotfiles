#!/bin/bash

windows_on_spaces() {

  local is_aerospace=$(aerospace list-workspaces --all 2>/dev/null)
  local is_omni=$(omniwmctl query active-workspace 2>/dev/null)

  args=()
  source "$HOME/.config/sketchybar/icon_map.sh"

  if [ "$is_aerospace" ]; then
    CURRENT_SPACES="$(yabai -m query --displays 2>/dev/null | jq -r '.[].spaces | @sh')"
    if [ -z "${CURRENT_SPACES}" ]; then
      CURRENT_SPACES="$(aerospace list-workspaces --all | tr '\n' ' ')"
    fi

    while read -r line; do
      for space in $line; do
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
            icon_strip+="${icon_result}"
          done <<<"$apps"
          space_args+=(label="$icon_strip" label.drawing=true)
        else
          space_args+=(label.drawing=false)
        fi
        args+=("${space_args[@]}")
      done
    done <<<"$CURRENT_SPACES"

  elif [ "$is_omni" ]; then
    WORKSPACES=$(omniwmctl query workspaces | jq '.result.payload.workspaces.[].number' | tr '\n' ' ')
    while read -r line; do
      for space in $line; do
        icon_strip=""
        space_args=(--set space.$space)
        apps=$(omniwmctl query windows --workspace $space | jq -r '.result.payload.windows.[].app.name')
        if [ -n "$apps" ]; then
          while IFS= read -r app; do
            __icon_map "${app}"
            icon_strip+="${icon_result}"
          done <<<"$apps"
          space_args+=(label="$icon_strip" label.drawing=true)
        else
          space_args+=(label.drawing=false)
        fi
        args+=("${space_args[@]}")
      done
    done <<<"$WORKSPACES"

  fi

  sketchybar -m "${args[@]}"
}

case "$SENDER" in
"forced")
  windows_on_spaces
  exit 0
  ;;
"window_focus")
  windows_on_spaces
  ;;
"windows_on_spaces")
  windows_on_spaces
  ;;
"space_windows_change")
  windows_on_spaces
  ;;
esac
