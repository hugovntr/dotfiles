#!/bin/sh

# Events
sketchybar -m --add event song_update com.apple.Music.playerInfo

# Styles
notch_popup=(
  popup.topmost=false
  drawing=true
  label.drawing=false
  # popup.y_offset=-68
  popup.drawing=true
  popup.background.color=0xFF000000
  popup.background.drawing=true
  popup.horizontal=true
  popup.align=center
  # popup.height=48
  # popup.background.corner_radius=12
  popup.y_offset=-48
  popup.height=42
  popup.background.corner_radius=48
)

music=(
  drawing=false
  script="$PLUGIN_DIR/music.sh"
  y_offset=-12
  padding_left=-40
  padding_right=16
  label.color="$LABEL_INACTIVE"
  label.font="$FONT_SANS:Sbd:11.0"
  icon.color="$BRAND400"
  updates=on
)

music_artwork=(
  drawing=false
  background.height=48
  background.border_color=0xFFFF0000
  background.drawing=true
  background.corner_radius=24
  # background.image.scale=0.055
  background.image.scale=0.070
  background.image.corner_radius=19
  background.image.padding_left=0
  background.image.padding_right=0
  padding_left=8
  padding_right=8
)

calendar=(
  icon.drawing=false
  icon="  "
  icon.y_offset=0
  icon.font="$FONT_ICON:Bold:15.0"
  icon.color=$LABEL_ACTIVE
  label.font="$FONT_SANS:Sbd:13.0"
  label.y_offset=0
  background.drawing=false
  background.color=0x00FFFFFF
  icon.padding_right=8
  label.align=left
  label.padding_right=4
  padding_left=8
  padding_right=16
  update_freq=30
  width=dynamic
  script="$PLUGIN_DIR/clock.sh"
  # y_offset=-4
  y_offset=0
)

weather=(
  icon=" "
  icon.font="$FONT_ICON:Bold:15.0"
  padding_left=16
  label.align=left
  y_offset=0
  script="$PLUGIN_DIR/weather.sh"
  update_freq=120
)

# Item
sketchybar --add item notch center \
  --set notch "${notch_popup[@]}" \
  --add item music.artwork popup.notch \
  --set music.artwork "${music_artwork[@]}" \
  --add item notch.weather popup.notch \
  --add item notch.calendar popup.notch \
  --set notch.weather "${weather[@]}" \
  --set notch.calendar "${calendar[@]}" \
  --add item music popup.notch \
  --set music "${music[@]}" \
  --subscribe notch.calendar system_woke \
  --subscribe music song_update
