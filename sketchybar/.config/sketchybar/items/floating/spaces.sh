#!/bin/bash

SPACE_ICONS=("󰬺" "󰬻" "󰬼" "󰬽" "󰬾")

sid=0
for i in "${!SPACE_ICONS[@]}"; do
  sid=$(($i + 1))

  space=(
    associated_display=1
    associated_space=$sid
    script="$PLUGIN_DIR/space.sh"
    padding_left=4
    padding_right=4

    # Space Icon
    icon=${SPACE_ICONS[$i]}
    icon.height=20
    icon.width=20
    icon.color=$LABEL_ACTIVE
    icon.highlight_color=$BRAND300
    icon.background.height=20
    icon.background.color=$BACKGROUND
    icon.background.corner_radius=5
    icon.background.border_width=2
    icon.padding_left=3
    icon.padding_right=0
    icon.font="$FONT_ICON:Semibold:22:0"

    # Applications
    label.padding_left=2
    label.padding_right=4
    label.font="sketchybar-app-font:Regular:14:0"
    #label.background.height=20
    #label.background.drawing=false
    #label.background.color=0x44190501
    #label.background.color=0x00000000
    #label.background.corner_radius=6
    #label.y_offset=0
    label.color=$BRAND100
    label.drawing=false

    background.height=20
    background.color=$BRAND300
    background.corner_radius=6
    background.border_width=0
    background.drawing=true
  )

  sketchybar --add space space.$sid left \
    --set space.$sid "${space[@]}"
done

space_manager=(
  drawing=false
  script="$PLUGIN_DIR/space_manager.sh"
  icon.font="$FONT_ICON:Bold:16.0"
  label.drawing=false
  icon.drawing=false
  icon.width=30
  associated_display=1
)

sketchybar --add event window_focus \
  --add event windows_on_spaces \
  --add item space_manager left \
  --set space_manager "${space_manager[@]}" \
  --subscribe space_manager window_focus \
  windows_on_spaces \
  space_windows_change

spaces=(
  background.height=26
  background.corner_radius=8
  background.color=$BACKGROUND_SUBTLE
  background.border_color=$BACKGROUND
  background.border_width=0
  background.drawing=true
)

sketchybar --add bracket spaces '/space\..*/' \
  --set spaces "${spaces[@]}"
