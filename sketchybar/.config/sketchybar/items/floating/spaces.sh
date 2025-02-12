#!/bin/bash

SPACE_ICONS=("1" "2" "3")

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
    padding_right=8
    icon=""
    icon.width=18
    icon.highlight_color=$BRAND900
    icon.padding_left=0
    icon.padding_right=0
    icon.font="$FONT:Semibold:18:0"
    label.padding_left=6
    label.padding_right=10
    label.font="sketchybar-app-font:Regular:11:0"
    label.background.height=18
    label.background.drawing=on
    label.background.color=0x44190501
    label.background.corner_radius=6
    label.y_offset=-1
    label.color=$BRAND50
    label.drawing=false
    background.color=0x00FFFFFF
    background.corner_radius=8
    background.border_width=0
    background.drawing=false
    background.height=4
    background.y_offset=12
  )

  sketchybar --add space space.$sid left    \
             --set space.$sid "${space[@]}" \
             --subscribe space.$sid mouse.clicked
done

spaces=(
  background.height=26
  background.corner_radius=8
  background.color=$BRAND
  background.border_color=$BACKGROUND
  background.border_width=0
  background.drawing=true
)

sketchybar --add bracket spaces '/space\..*/' \
           --set spaces "${spaces[@]}"        \
