#!/bin/bash

space_manager=(
  script="$PLUGIN_DIR/space_manager.sh"
  icon.font="$FONT:Bold:16.0"
  label.drawing=on
  icon.drawing=off
  icon.width=30
  icon=$YABAI_GRID
  icon.color=$BRAND
  associated_display=active
)

front_app=(
  script="$PLUGIN_DIR/front_app.sh"
  icon.font="sketchybar-app-font:Regular:14:0"
  label.font="$FONT:Semibold:12.0"
  associated_display=active
  label.padding_left=8
  label.padding_right=4
  icon.color=$BRAND
  icon.padding_left=8
  icon.padding_right=8
  icon.background.drawing=true
  icon.background.color=$BACKGROUND
  icon.background.height=22
  icon.background.corner_radius=4
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
