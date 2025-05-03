#!/bin/sh

# Event
sketchybar -m --add event song_update com.apple.Music.playerInfo

# Item
sketchybar -m --add item music center \
  --set music_artwork background.image.scale=0.1 \
                      background.height=56 \
                      background.width=56 \
  --set music script="$PLUGIN_DIR/music.sh" \
              drawing=off \
              updates=true \
              label.y_offset=12 \
              label.padding_right=16 \
  --subscribe music song_update \
  --subscribe music_artwork song_update

