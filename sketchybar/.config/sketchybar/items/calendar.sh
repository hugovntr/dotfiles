#!/bin/bash

calendar=(
  icon="󰥔 "
  icon.font="$FONT:Bold:16.0"
  label.font="$FONT:Bold:12.0"
  icon.padding_right=8
  label.align=right
  padding_left=15
  update_freq=30
  script="$PLUGIN_DIR/clock.sh"
)

sketchybar --add item calendar right       \
           --set calendar "${calendar[@]}" \
           --subscribe calendar system_woke
