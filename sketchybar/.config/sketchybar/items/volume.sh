#!/bin/bash

volume_slider=(
  script="$PLUGIN_DIR/volume.sh"
  updates=on
  label.drawing=off
  icon.drawing=off
  slider.highlight_color=$BRAND
  slider.background.height=5
  slider.background.corner_radius=3
  slider.background.color=$BACKGROUND
  slider.knob.font="$FONT:Bold:13.0"
  slider.knob=" "
  slider.knob.drawing=off
)

volume_icon=(
  click_script="$SCRIPTS_DIR/volume_click.sh"
  padding_left=10
  padding_right=0
  icon.width=0
  icon.align=left
  icon.color=$LABEL_INACTIVE
  icon.font="$FONT:Regular:16.0"
  label.width=25
  label.align=left
  label.font="$FONT:Regular:20.0"
)

sketchybar --add slider volume right            \
           --set volume "${volume_slider[@]}"   \
           --subscribe volume volume_change     \
                              mouse.clicked     \
                              mouse.entered     \
                              mouse.exited      \
                                                \
           --add item volume_icon right         \
           --set volume_icon "${volume_icon[@]}"
