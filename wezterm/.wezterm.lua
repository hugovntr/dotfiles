local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Session Manager
local session_manager = require("sessions")
wezterm.on("save-session", function(window)
	session_manager.save_state(window)
end)
wezterm.on("load-session", function(window)
	session_manager.load_state(window)
end)
wezterm.on("restore-session", function(window)
	session_manager.restore_state(window)
end)

-- Automatically start tmux
-- wezterm.on("gui-startup", function(cmd)
-- 	local mux = wezterm.mux
-- 	local _, build_pane, _ = mux.spawn_window(cmd or {})
-- 	build_pane:send_text("tmux\n")
-- end)

-- Automagically reload the configuration
config.automatically_reload_config = true

-- Quit confirmation
config.window_close_confirmation = "NeverPrompt"

-- Focus follows mouse
config.pane_focus_follows_mouse = false

-- Max FPS
config.max_fps = 120
config.animation_fps = 120
-- config.front_end = "WebGpu"

-- Keybindings
config.enable_kitty_keyboard = true
config.leader = { key = "q", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = require("keys")

-- Font size / Term size
config.line_height = 1.2
config.initial_rows = 54
config.initial_cols = 256
config.default_cursor_style = "SteadyBar"

-- Window Decorations
config.window_decorations = "RESIZE"
config.enable_scroll_bar = false
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 24
config.window_padding = {
	left = 4,
	right = 4,
	top = 2,
	bottom = 2,
}
config.inactive_pane_hsb = {
	brightness = 0.3,
	saturation = 0.9,
}

-- Transparency and Colors
config.colors = require("colors")
config.window_background_opacity = 0.85
config.macos_window_background_blur = 64

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

	local icon = tab.is_active and " " or " "
	title = string.format(" %s %s ", icon, title)

	local background = config.colors.tab_bar.background
	local foreground = "white"

	if hover then
		background = "rgb(22, 24, 26 / 60%)"
		foreground = "White"
	end

	if tab.is_active then
		background = "#fa7a61"
		foreground = "Black"
	end

	return {
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
	}
end)

return config
