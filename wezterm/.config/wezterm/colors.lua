local themes = {
	custom = {
		foreground = "#ffffff",
		background = "#09090b",

		cursor_bg = "#ffffff",
		cursor_fg = "#000000",
		cursor_border = "#ffffff",

		selection_fg = "#ffffff",
		selection_bg = "#3c4048",

		scrollbar_thumb = "#16181a",
		split = "rgb(0, 0, 0 / 0%)",

		ansi = { "#16181a", "#ff6e5e", "#5eff6c", "#f1ff5e", "#5ea1ff", "#bd5eff", "#5ef1ff", "#ffffff" },
		brights = { "#6b7280", "#ff6e5e", "#5eff6c", "#f1ff5e", "#5ea1ff", "#bd5eff", "#5ef1ff", "#ffffff" },
		indexed = { [16] = "#ffbd5e", [17] = "#ff6e5e" },
	},
}

local function merge(f, s)
	for k, v in pairs(s) do
		f[k] = v
	end
	return f
end

local M = merge(themes.custom, {
	tab_bar = {
		background = "rgb(9, 9, 11 / 95%)",
	},
})

return M
