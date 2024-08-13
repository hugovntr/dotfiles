source "$CONFIG_DIR/constants.sh"

mode_changed() {
  case "$MODE" in
    "service") args=(
      icon="󰒔"
      icon.color="$MAROON"
      label="Service"
    )
    ;;
    "move") args=(
      icon="󰆾"
      icon.color="$SKY"
      label="Move"
    )
    ;;
    "resize") args=(
      icon="󰩨"
      icon.color="$YELLOW"
      label="Resize"
    )
    ;;
    *) args=(
      icon="󰙀"
      icon.color="$WHITE"
      label="Default"
    )
    ;;
  esac
  sketchybar --set modes "${args[@]}"
}


case "$SENDER" in
  "mode_changed") mode_changed
  ;;
esac
