#!/bin/bash

front_app=(
  drawing=true
  script="$PLUGIN_DIR/front_app.sh"
  label.font="$FONT_SANS:Bold:12.0"
  icon.font="sketchybar-app-font:Regular:16:0"
  associated_display=active
  padding_left=16
  label.y_offset=1
  label.padding_left=6
  label.padding_right=0
  label.color=$LABEL_ACTIVE
  icon.drawing=false
  icon.color=$BRAND500
  icon.width=16
  icon.height=16
  icon.padding_left=0
  icon.background.drawing=false
  icon.background.height=24
  icon.background.corner_radius=4
)

sketchybar --add item front_app left \
  --set front_app "${front_app[@]}" \
  --subscribe front_app front_app_switched
