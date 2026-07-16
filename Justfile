# Run the theme manager script
[group("scripts")]
theme name='forest':
  bun run ./bin/themes/set-theme.ts {{name}}

fixaudio:
  ./bin/fixaudio/script.sh
