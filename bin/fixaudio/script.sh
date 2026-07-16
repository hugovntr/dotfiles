#!/bin/bash
# fixaudio — workaround for macOS Tahoe audio degradation bug
# Kills all CoreAudio clients + all audio daemons to restore normal audio.
#
# Usage: source this file and run `fixaudio`, or add the function to your .zshrc/.bashrc.
# Requires sudo for killing system audio daemons.

fixaudio() {
  sudo -v || return 1

  local skip="coreaudiod|audiomxd|audioclocksyncd|audioanalyticsd|audioaccessoryd|AudioComponentRegistrar|audio.DriverHelper|audio.SandboxHelper|ParrotAudioPlugin"

  echo "=== Audio clients ==="
  lsof 2>/dev/null | grep CoreAudio | awk '{print $2, $1}' | sort -t' ' -k1,1 -un | grep -vE "$skip" | while read pid name; do
    echo "  kill $name ($pid)"
    kill -9 "$pid" 2>/dev/null
  done

  killall Xcode SimulatorTrampoline com.apple.CoreSimulator.CoreSimulatorService simdiskimaged 2>/dev/null

  sleep 1
  echo "=== Audio daemons ==="
  sudo killall -9 coreaudiod audiomxd audioclocksyncd audioanalyticsd audioaccessoryd AudioComponentRegistrar 2>/dev/null
  echo "  killed all audio daemons"

  sleep 2
  echo "=== Done. coreaudiod PID: $(pgrep coreaudiod) ==="
}

fixaudio
