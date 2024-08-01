#!/bin/sh

# Event
# sketchybar -m --add event song_update com.apple.iTunes.playerInfo

# Item
sketchybar -m --add item music right \
  --set music script="$PLUGIN_DIR/music.sh" \
  drawing=off \
  update_freq=30 \
  label.padding_right=8 \
  --subscribe music media_change
