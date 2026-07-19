# Run the theme manager script
[group("scripts")]
theme name='forest':
  bun run ./bin/themes/set-theme.ts {{name}}

fixaudio:
  ./bin/fixaudio/script.sh

qmk:
  qmk flash -kb lily58 -km hugo -e CONVERT_TO=promicro_rp2040
