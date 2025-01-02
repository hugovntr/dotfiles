local wezterm = require("wezterm")
local act = wezterm.action

local function is_nvim(pane)
	local process_name = string.gsub(pane:get_foreground_process_name(), "(.*[/\\])(.*)", "%2")
	return process_name == "nvim" or process_name == "vim"
end

local function is_tmux(pane)
	local process_name = string.gsub(pane:get_foreground_process_name(), "(.*[/\\])(.*)", "%2")
	return process_name == "tmux"
end

local direction_keys = {
	Left = "j",
	Up = "k",
	Down = "l",
	Right = "m",
}

local function pane_navigation(key, mods, action)
	return {
		key = key,
		mods = mods,
		action = wezterm.action_callback(function(win, pane)
			if is_nvim(pane) then
				win:perform_action({
					SendKey = { key = key, mods = mods },
				}, pane)
			elseif is_tmux(pane) then
				if key == "m" then
					win:perform_action({
						SendKey = { key = "h", mods = mods },
					}, pane)
				else
					win:perform_action({
						SendKey = { key = key, mods = mods },
					}, pane)
				end
			else
				win:perform_action(action, pane)
			end
		end),
	}
end

local function nvim_action(key, mods, action)
	return {
		key = key,
		mods = mods,
		action = wezterm.action_callback(function(win, pane)
			if is_nvim(pane) then
				win:perform_action(action, pane)
			else
				win:perform_action({
					SendKey = { key = key, mods = mods },
				}, pane)
			end
		end),
	}
end

local function term_action(key, mods, action)
	return {
		key = key,
		mods = mods,
		action = wezterm.action_callback(function(win, pane)
			if not is_nvim(pane) then
				if is_tmux(pane) then
					win:perform_action({
						SendKey = { key = "g", mods = "CTRL" },
					}, pane)
					return
				end
				win:perform_action(action, pane)
			else
				win:perform_action({
					SendKey = { key = key, mods = mods },
				}, pane)
			end
		end),
	}
end

local keys = {
	term_action(
		"k",
		"CMD",
		act.Multiple({
			act.ClearScrollback("ScrollbackAndViewport"),
			act.SendKey({ key = "l", mods = "CTRL" }),
		})
	),
	-- Temporary mod
	{ key = "e", mods = "CMD", action = act.SendKey({ key = "e", mods = "ALT" }) },
	{ key = "s", mods = "CMD", action = act.SendKey({ key = "s", mods = "ALT" }) },
	{ key = "p", mods = "CMD", action = act.SendKey({ key = "p", mods = "ALT" }) },
	{ key = "Backspace", mods = "CMD", action = act.SendKey({ mods = "CTRL", key = "u" }) },
	{ key = "m", mods = "OPT", action = act.DisableDefaultAssignment },

	-- MacOS Keys
	{ key = "LeftArrow", mods = "OPT", action = act({ SendString = "\x1bb" }) },
	{ key = "RightArrow", mods = "OPT", action = act({ SendString = "\x1bf" }) },
	{ key = "LeftArrow", mods = "CMD", action = act({ SendString = "\u{1}" }) },
	{ key = "RightArrow", mods = "CMD", action = act({ SendString = "\u{5}" }) },

	-- TMUX
	{ key = "d", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "f", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = false }) },
	{ key = "ù", mods = "LEADER", action = act.TogglePaneZoomState },
	{ key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
	{ key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
	{ key = "Space", mods = "LEADER", action = act.PaneSelect({ mode = "SwapWithActive" }) },
	{ key = "r", mods = "LEADER", action = act.ReloadConfiguration },
	{
		key = "t",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = "Enter new tab name",
			action = wezterm.action_callback(function(window, _, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	{ key = "i", mods = "LEADER", action = act.EmitEvent("save-session") },
	{ key = "o", mods = "LEADER", action = act.EmitEvent("restore-session") },

	-- Adjust Pane size
	{
		key = "g",
		mods = "LEADER",
		action = act.ActivateKeyTable({
			name = "resize_pane",
			one_shot = false,
		}),
	},

	-- Move between panes
	pane_navigation(direction_keys["Left"], "CTRL", act.ActivatePaneDirection("Left")),
	pane_navigation(direction_keys["Up"], "CTRL", act.ActivatePaneDirection("Up")),
	pane_navigation(direction_keys["Down"], "CTRL", act.ActivatePaneDirection("Down")),
	pane_navigation(direction_keys["Right"], "CTRL", act.ActivatePaneDirection("Right")),

	-- Neovim Specials
	nvim_action("Delete", nil, act.SendKey({ key = "Delete", mods = "CTRL" })),
}

local key_tables = {
	resize_pane = {
		-- Exit resize mode
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "m", action = act.AdjustPaneSize({ "Right", 20 }) },
		{ key = "j", action = act.AdjustPaneSize({ "Left", 20 }) },
		{ key = "k", action = act.AdjustPaneSize({ "Up", 5 }) },
		{ key = "l", action = act.AdjustPaneSize({ "Down", 5 }) },
	},
}

return {
	leader = { key = "q", mods = "CTRL" },
	keys = keys,
	key_tables = key_tables,
}
