#!/usr/bin/env sh

loop() {
  local script=$0
  open -a "OmniWM"

  # Ensure that OmniWM is started
  while ! omniwmctl ping; do
    sleep 5
  done

  (
    trap 'kill 0' SIGINT
    # Start OmniWM watchers
    omniwmctl watch active-workspace --no-send-initial --exec sketchybar --trigger space_change &
    omniwmctl watch focus --exec $script focus &

    # Start sketchybar
    sketchybar &

    # wait
    wait
  )
}

# Main loop
if [[ -z $1 ]]; then
  loop $0

# Triggers everytime the focus changes
elif [ $1 = "focus" ]; then
  win=$(omniwmctl query windows --focused | jq '.result.payload.windows[0]')
  workspace=$(echo "${win}" | jq -r '.workspace.number')
  layout=$(echo "${win}" | jq -r '.mode')

  # Windows on the second workspace are automatically
  # floating.
  if [[ $workspace = 2 && $layout != "floating" ]]; then
    omniwmctl command toggle-focused-window-floating 2>&1 >/dev/null
  fi
fi
