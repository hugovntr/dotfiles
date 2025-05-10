modes=(
  script="$PLUGIN_DIR/mode.sh"
  icon.font="$FONT_ICON:Regular:16.0"
  icon.y_offset=0.5
  icon.color=$WHITE
  icon.width=24
  icon.padding_left=8
  label.color="0xFFFFFFFF"
  label.font="$FONT_SANS:Sbd:11.0"
  label.y_offset=1
  label.align=left
  label.padding_left=4
  label.padding_right=10
  label.width=dynamic
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
