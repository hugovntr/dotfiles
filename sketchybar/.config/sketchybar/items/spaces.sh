#!/bin/bash

SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9")

# Destroy space on right click, focus space on left click.
# New space by left clicking separator (>)

sid=0
spaces=()
for i in "${!SPACE_ICONS[@]}"
do
  sid=$(($i+1))

  space=(
    associated_space=$sid
    script="$PLUGIN_DIR/space.sh"
    padding_left=4
    padding_right=4
    icon=${SPACE_ICONS[i]}
    icon.highlight_color=$BRAND
    icon.padding_left=16
    icon.padding_right=8
    icon.font="$FONT:Semibold:16:0"
    label.padding_left=4
    label.padding_right=10
    label.font="sketchybar-app-font:Regular:13:0"
    label.background.height=20
    label.background.drawing=on
    label.background.color=$BACKGROUND
    label.background.corner_radius=4
    label.color=$LABEL_INACTIVE
    label.drawing=off
    background.color=$BACKGROUND
    background.corner_radius=8
    background.border_width=0
    background.drawing=false
  )

  sketchybar --add space space.$sid left    \
             --set space.$sid "${space[@]}" \
             --subscribe space.$sid mouse.clicked
done

spaces=(
  background.color=$BACKGROUND
  background.border_color=$BACKGROUND
  background.border_width=2
  background.drawing=on
)

separator=(
  icon=
  icon.font="$FONT:Bold:16.0"
  icon.color=$WHITE
  padding_left=15
  padding_right=15
  label.drawing=off
  associated_display=active
  click_script='yabai -m space --create && sketchybar --trigger space_change'
)

sketchybar --add bracket spaces '/space\..*/' \
           --set spaces "${spaces[@]}"        \
                                              \
           --add item separator left          \
           --set separator "${separator[@]}"
