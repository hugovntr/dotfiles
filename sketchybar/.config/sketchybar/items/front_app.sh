#!/bin/bash

yabai=(
  script="$PLUGIN_DIR/yabai.sh"
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
           --add item yabai left               \
           --set yabai "${yabai[@]}"           \
           --subscribe yabai window_focus      \
                             windows_on_spaces \
                                               \
           --add item front_app left           \
           --set front_app "${front_app[@]}"   \
           --subscribe front_app front_app_switched
