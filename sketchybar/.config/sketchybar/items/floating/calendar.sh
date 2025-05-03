#!/bin/bash

calendar=(
  icon="󰥔 "
  icon.font="$FONT:Bold:16.0"
  label.font="$FONT:Bold:12.0"
  label.y_offset=0
  background.drawing=false
  background.color=0x00FFFFFF
  icon.padding_right=8
  label.align=left
  padding_left=16
  padding_right=8
  update_freq=30
  script="$PLUGIN_DIR/clock.sh"
  y_offset=12
)

sketchybar --add item calendar center       \
           --set calendar "${calendar[@]}" \
           --subscribe calendar system_woke
