#!/bin/sh

# Events
sketchybar -m --add event song_update com.apple.Music.playerInfo

# Styles
notch_popup=(
  popup.topmost=false
  drawing=true
  label.drawing=false
  popup.y_offset=-68
  popup.drawing=true
  popup.background.color=$BACKGROUND
  popup.background.drawing=true
  popup.horizontal=true
  popup.align=center
  popup.height=48
  popup.background.corner_radius=12
)

music=(
  drawing=false
  script="$PLUGIN_DIR/music.sh"
  y_offset=-12
  padding_left=-16
  padding_right=16
  label.color="$LABEL_INACTIVE"
  label.font="$FONT_SANS:Sbd:11.0"
  icon.color="$BRAND400"
)

music_artwork=(
  drawing=false
  background.height=48
  background.border_color=0xFFFF0000
  background.drawing=true
  background.corner_radius=6
  background.image.scale=0.055
  background.image.corner_radius=6
  background.image.padding_left=0
  background.image.padding_right=0
  padding_left=8
  padding_right=8
)

calendar=(
  icon="  "
  icon.y_offset=0
  icon.font="$FONT_ICON:Bold:16.0"
  icon.color="$LABEL_INACTIVE"
  label.font="$FONT_SANS:Sbd:13.0"
  label.y_offset=0
  background.drawing=false
  background.color=0x00FFFFFF
  icon.padding_right=8
  label.align=left
  label.padding_right=4
  padding_left=16
  padding_right=16
  update_freq=30
  script="$PLUGIN_DIR/clock.sh"
  y_offset=-4
)

# Item
sketchybar --add item notch center \
  --set notch "${notch_popup[@]}" \
  --add item music.artwork popup.notch \
  --set music.artwork "${music_artwork[@]}" \
  --add item notch.calendar popup.notch \
  --set notch.calendar "${calendar[@]}" \
  --add item music popup.notch \
  --set music "${music[@]}" \
  --subscribe notch.calendar system_woke \
  --subscribe music song_update
