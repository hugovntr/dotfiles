modes=(
  script="$PLUGIN_DIR/mode.sh"
  icon.font="$FONT:Bold:16.0"
  icon.color=$WHITE
  icon.width=24
  icon.padding_left=8
  label.color="0xFFFFFFFF"
  label.font="$FONT:Bold:11.0"
  label.y_offset=0
  label.align=left
  label.padding_left=4
  label.width=dynamic
  padding_left=16
  padding_right=16
  associated_display=active
  background.drawing=true
  background.color=$BACKGROUND
  background.height=26
  background.corner_radius=8
  label.padding_right=8
  width=dynamic
)


sketchybar --add item modes left \
           --add event mode_changed \
           --set modes "${modes[@]}" \
           --subscribe modes mode_changed

sketchybar --trigger mode_changed MODE=default
