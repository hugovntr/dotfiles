#!/bin/bash

space_manager=(
  script="$PLUGIN_DIR/space_manager.sh"
  icon.font="$FONT:Bold:16.0"
  label.drawing=on
  icon.width=30
  icon=$YABAI_GRID
  icon.color=$BRAND
  associated_display=active
)

front_app=(
  script="$PLUGIN_DIR/front_app.sh"
  label.font="$FONT:Bold:13.0"
  associated_display=active
)

sketchybar --add event window_focus            \
           --add event windows_on_spaces       \
           --add item space_manager left               \
           --set space_manager "${space_manager[@]}"           \
           --subscribe space_manager window_focus      \
                             windows_on_spaces \

sketchybar --add item front_app left           \
           --set front_app "${front_app[@]}"   \
           --subscribe front_app front_app_switched
