local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

wezterm.on("gui-startup", function(cmd)
	local mux = wezterm.mux
	local _, build_pane, _ = mux.spawn_window(cmd or {})
	build_pane:send_text("tmux\n")
end)

-- Automagically reload the configuration
config.automatically_reload_config = true

-- Disable quit confirmation
config.window_close_confirmation = "NeverPrompt"
config.pane_focus_follows_mouse = true

-- Max FPS
config.max_fps = 120
config.animation_fps = 120

-- Keybindings
config.enable_kitty_keyboard = true
-- config.leader = { key = "q", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = require("keys")

-- Font size / Term size
config.line_height = 1.2
config.initial_rows = 54
config.initial_cols = 256

-- Window Decorations
config.window_decorations = "RESIZE"
config.enable_scroll_bar = false
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 24
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- Transparency and Colors
config.color_scheme = "Catppuccin Mocha"
config.colors = require("colors")
config.window_background_opacity = 0.9
config.macos_window_background_blur = 16

local function tab_title(tab_info)
	local title = tab_info.tab_title

	if title and #title > 0 then
		return title
	end

	return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, cf, hover, max_width)
	local title = tab_title(tab)

	title = wezterm.truncate_left(title, max_width)
	local i = tab.tab_index + 1

	title = string.format(" %d %s ", i, title)

	local background = "rgb(22, 24, 26 / 20%)"
	local foreground = "white"

	if tab.is_active then
		background = "rgb(22, 24, 26 / 90%)"
		foreground = "white"
	end

	return {
		{ Background = { Color = "black" } },
		{ Foreground = { Color = "black" } },
		{ Text = "" },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
		{ Background = { Color = "black" } },
		{ Foreground = { Color = "black" } },
		{ Text = "" },
	}
end)

return config
