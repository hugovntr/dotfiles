modes=(
  script="$PLUGIN_DIR/mode.sh"
  icon.font="$FONT:Bold:16.0"
  icon.color=$WHITE
  icon.width=16
  label.color="0xBFFFFFFF"
  label.font.size="12.0"
  label.y_offset=-1
  label.align=left
  label.padding_left=4
  label.width=56
  padding_left=16
  padding_right=16
  associated_display=active
)


sketchybar --add item modes left \
           --add event mode_changed \
           --set modes "${modes[@]}" \
           --subscribe modes mode_changed

sketchybar --trigger mode_changed MODE=default
