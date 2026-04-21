#!/bin/bash

space_manager=(
  script="$PLUGIN_DIR/space_manager.sh"
  icon.font="$FONT_ICON:Bold:16.0"
  label.drawing=on
  icon.drawing=off
  icon.width=30
  icon=$YABAI_GRID
  associated_display=active
)

front_app=(
  script="$PLUGIN_DIR/front_app.sh"
  label.font="$FONT_SANS:Bold:12.0"
  icon.font="sketchybar-app-font:Regular:16:0"
  associated_display=active
  padding_left=16
  label.y_offset=1
  label.padding_left=6
  label.padding_right=0
  icon.drawing=false
  icon.color=$BRAND200
  icon.width=16
  icon.height=16
  icon.padding_left=0
  icon.padding_right=0
  icon.background.drawing=false
  icon.background.color=0x00FFFFFF
  icon.background.height=0
  icon.background.corner_radius=4
)

sketchybar --add event window_focus \
  --add event windows_on_spaces \
  --add item space_manager left \
  --set space_manager "${space_manager[@]}" \
  --subscribe space_manager window_focus \
  windows_on_spaces

sketchybar --add item front_app left \
  --set front_app "${front_app[@]}" \
  --subscribe front_app front_app_switched
