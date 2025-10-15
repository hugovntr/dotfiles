# NeoVim

## Architecture
```
lua
├── config/
│   ├── keymaps.lua
│   ├── lazy.lua
│   └── options.lua
├── custom/
│   ├── autotheme/
│   └── themes/
├── plugins/
│   ├── config/
│   └── ...
└── init.lua
```

- `config/`: Contains all the configuration overrides, like key maps and options.
- `custom/`: Local development directory
- `plugins/`: Plugins directory

## Configurations

### Key maps
Defined in `lua/config/keymaps.lua`, they can all easily be modified.
The most notable change being the use of `jklm` for navigation, opposed to the traditional `hjkl`.

### LazyVim configuration
Classic **LazyVim** configuration, with only change being the `dev` path the was changed from `~/projects` (default) to `~/.config/nvim/lua/custom/`

### Options
Same deal, nothing really major here, the leader key is defined to be `Space`. Almost everything is documented inside the file

## Plugins
They are grouped by scope:
- `ai.lua`: All plugins related to AI use
- `code.lua`: Code essentials (formatter, linter, autocomplete, ...)
- `lsp.lua`: LSP server configurations
- `navigation.lua`: Navigation inside the editor and outside (mainly with tmux)
- `qol.lua`: Quality-of-Life improvement plugins
- `style.lua`: Appearance of the editor

### Custom plugins
All home-made plugins are located in the `lua/custom/` folder. There's also custom themes (extended from [Forest Night](https://github.com/adibhanna/forest-night.nvim))

Currently, the only "home-made" plugin is the `autotheme` which uses [dark-notify](https://github.com/cormacrelf/dark-notify) to change the color scheme of the editor based on the system appearance.
