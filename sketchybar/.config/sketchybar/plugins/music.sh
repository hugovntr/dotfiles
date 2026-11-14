#!/bin/bash
LAST_FILE="/tmp/sketchybar_music_last"     # last payload processed
LATEST_FILE="/tmp/sketchybar_music_latest" # newest payload seen
LOCK_DIR="/tmp/sketchybar_music.lock"
TRACK_FILE="/tmp/sketchybar_music_track"
ART_DIR="/tmp/sketchybar_music_art"
ART_PTR="$ART_DIR/current" # holds the path of the artwork to display
mkdir -p "$ART_DIR"

# Cheap exits first: nothing expensive for duplicate events
[ "$INFO" = "$(cat "$LAST_FILE" 2>/dev/null)" ] && exit 0
printf '%s' "$INFO" >"$LATEST_FILE"
mkdir "$LOCK_DIR" 2>/dev/null || exit 0 # holder will pick up LATEST_FILE
trap 'rmdir "$LOCK_DIR"' EXIT

source "$HOME/.config/sketchybar/constants.sh"
ARTWORK_LOCATION="$HOME/album_art.tiff"

reset_bar() {
  sketchybar --set music drawing=off \
    --set music.artwork drawing=off \
    --animate tanh 10 \
    --set notch popup.height=42 \
    --set notch.calendar width=dynamic y_offset=0 \
    --set notch.weather padding_left=16 y_offset=0
}

# Watchdog path: timer or startup, no payload
if [ -z "$INFO" ]; then
  pgrep -x Music >/dev/null && exit 0                       # Music alive, events handle it
  [ "$(cat "$TRACK_FILE" 2>/dev/null)" = "none" ] && exit 0 # already reset, nothing to do
  mkdir "$LOCK_DIR" 2>/dev/null || exit 0
  trap 'rmdir "$LOCK_DIR"' EXIT
  reset_bar
  printf '%s' "none" >"$TRACK_FILE"
  rm -f "$LAST_FILE" # so the next payload isn't mistaken for a duplicate
  exit 0
fi

fetch_artwork() { # args: track_id artist album
  local id="$1" artist="$2" album="$3" out q url
  out="$ART_DIR/$id.img"

  if [ ! -s "$out" ]; then
    # 1) Ask Music itself for the current track's artwork
    osascript <<EOF >/dev/null 2>&1
try
  tell application "Music" to set d to raw data of artwork 1 of current track
  set f to open for access POSIX file "$out" with write permission
  set eof f to 0
  write d to f
  close access f
end try
EOF
  fi

  if [ ! -s "$out" ]; then
    # 2) Fallback: iTunes Search API
    rm -f "$out"
    q=$(printf '%s %s' "$artist" "$album" | jq -sRr @uri)
    url=$(curl -s "https://itunes.apple.com/search?term=$q&entity=album&limit=1" |
      jq -r '.results[0].artworkUrl100 // empty')
    [ -n "$url" ] && curl -s "${url/100x100bb/720x720bb}" -o "$out"
  fi

  if [ -s "$out" ]; then
    printf '%s' "$out" >"$ART_PTR"
    # keep only the 5 most recent images
    ls -t "$ART_DIR"/*.img 2>/dev/null | tail -n +6 | xargs rm -f
  fi
  # on total failure, the pointer keeps the previous artwork
}

process() {
  local info="$1" state track_id title artist icon prev_track
  state=$(echo "$info" | jq -r '."Player State" // "Stopped"')
  track_id=$(echo "$info" | jq -r '.PersistentID // "none"')
  title=$(echo "$info" | jq -r '.Name // empty')
  artist=$(echo "$info" | jq -r '.Artist // empty')
  album=$(echo "$info" | jq -r '.Album // empty')

  if [ "$state" = "Stopped" ] || [ -z "$title" ]; then
    if [ "$(cat "$TRACK_FILE" 2>/dev/null)" != "none" ]; then # reset only once
      reset_bar
      printf '%s' "none" >"$TRACK_FILE"
    fi
    return
  fi

  case "$state" in
  Playing) icon=" " ;;
  Paused) icon="" ;;
  esac

  prev_track=$(cat "$TRACK_FILE" 2>/dev/null)
  if [ "$track_id" != "$prev_track" ]; then
    fetch_artwork "$track_id" "$artist" "$album"
    printf '%s' "$track_id" >"$TRACK_FILE"
  fi
  ARTWORK_LOCATION=$(cat "$ART_PTR" 2>/dev/null)

  [ ${#title} -gt 25 ] && title="${title:0:25}…"
  [ ${#artist} -gt 25 ] && artist="${artist:0:25}…"

  local label="${artist} - ${title}"
  local label_width="dynamic"
  [ $((${#label} * 7)) -lt 128 ] && label_width=128

  sketchybar --set music \
    icon="$icon" icon.font="$FONT_ICON:Bold:15.0" \
    icon.y_offset=0 icon.padding_right=8 \
    label="$label" width=$label_width drawing=true \
    --set music.artwork \
    drawing=true label.drawing=false icon.drawing=false \
    background.color="$TRANSPARENT" \
    background.image.string="$ARTWORK_LOCATION"

  sketchybar --animate tanh 10 \
    --set notch popup.height=56 \
    --animate tanh 10 \
    --set notch.calendar y_offset=10 width=0 icon.drawing=false \
    --animate tanh 10 \
    --set notch.weather padding_left=8 y_offset=11
}

# Catch-up loop: process until nothing newer has arrived
while true; do
  CUR=$(cat "$LATEST_FILE")
  [ "$CUR" = "$(cat "$LAST_FILE" 2>/dev/null)" ] && break
  printf '%s' "$CUR" >"$LAST_FILE"
  process "$CUR"
done
