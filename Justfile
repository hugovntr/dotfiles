# Run the theme manager script
[group("scripts")]
theme name='forest':
  bun run ./bin/themes/set-theme.ts {{name}}

fixaudio:
  ./bin/fixaudio/script.sh

# Build the tmux pane-border plugin
pane-border:
  cd tmux/.config/tmux/plugins/tmux-pane-border && go build -o bin/tmux-pane-border .

qmk:
  qmk flash -kb lily58 -km hugo -e CONVERT_TO=promicro_rp2040
