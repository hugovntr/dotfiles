local wezterm = require("wezterm")
local act = wezterm.action
return {
	-- {
	-- 	key = "m",
	-- 	mods = "CMD",
	-- 	action = wezterm.action.DisableDefaultAssignment,
	-- },
	{ key = "k", mods = "CMD", action = act.SendKey({ mods = "CTRL", key = "l" }) },
	{ key = "j", mods = "CTRL", action = act.DisableDefaultAssignment },
	{ key = "k", mods = "CTRL", action = act.DisableDefaultAssignment },
	{ key = "l", mods = "CTRL", action = act.SendKey({ key = "l", mods = "CTRL|OPT" }) },
	{ key = "m", mods = "CTRL", action = act.SendKey({ key = "k", mods = "CTRL|OPT" }) },
	-- Temporary mod
	{ key = "e", mods = "CMD", action = act.SendKey({ key = "e", mods = "ALT" }) },
	{ key = "s", mods = "CMD", action = act.SendKey({ key = "s", mods = "ALT" }) },
	{ key = "Backspace", mods = "CMD", action = act.SendKey({ mods = "CTRL", key = "u" }) },
	-- MacOS Keys
	{ key = "LeftArrow", mods = "OPT", action = act({ SendString = "\x1bb" }) },
	{ key = "RightArrow", mods = "OPT", action = act({ SendString = "\x1bf" }) },
	{ key = "LeftArrow", mods = "CMD", action = act({ SendString = "\u{1}" }) },
	{ key = "RightArrow", mods = "CMD", action = act({ SendString = "\u{5}" }) },

	-- TMUX
	-- { key = "d", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	-- { key = "f", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	-- { key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = false }) },
	-- { key = "ù", mods = "LEADER", action = act.TogglePaneZoomState },
	-- { key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
	-- { key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
	-- { key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
	--
	-- -- Adjust Pane size
	-- { key = "m", mods = "LEADER", action = act.AdjustPaneSize({ "Right", 5 }) },
	-- { key = "j", mods = "LEADER", action = act.AdjustPaneSize({ "Left", 5 }) },
	-- { key = "k", mods = "LEADER", action = act.AdjustPaneSize({ "Up", 5 }) },
	-- { key = "l", mods = "LEADER", action = act.AdjustPaneSize({ "Down", 5 }) },
	--
	-- -- Move between panes
	-- { key = "m", mods = "CTRL", action = act.ActivatePaneDirection("Right") },
	-- { key = "j", mods = "CTRL", action = act.ActivatePaneDirection("Left") },
	-- { key = "k", mods = "CTRL", action = act.ActivatePaneDirection("Up") },
	-- { key = "l", mods = "CTRL", action = act.ActivatePaneDirection("Down") },
}
