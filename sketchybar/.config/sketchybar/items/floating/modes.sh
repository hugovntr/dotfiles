modes=(
  script="$PLUGIN_DIR/mode.sh"
  icon.font="$FONT_ICON:Regular:14.0"
  icon.y_offset=1
  icon.color=$WHITE
  icon.width=24
  icon.padding_left=8
  label.color=$WHITE
  label.font="$FONT_SANS:Sbd:11.5"
  label.y_offset=1
  label.align=left
  label.padding_left=2
  label.padding_right=0
  label.width=52
  padding_left=16
  padding_right=16
  associated_display=active
  background.drawing=true
  background.color=$BACKGROUND
  background.height=24
  background.corner_radius=6
  width=dynamic
)

sketchybar --add item modes left \
  --add event mode_changed \
  --set modes "${modes[@]}" \
  --subscribe modes mode_changed

sketchybar --trigger mode_changed MODE=default
