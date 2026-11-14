#!/bin/sh

WEATHER=$(curl -s 'https://wttr.in/Bourgoin+Jallieu?m&format=%c')
if [[ ! $WEATHER ]]; then
  exit 0
else
  sketchybar --set $NAME icon="$WEATHER"
fi
