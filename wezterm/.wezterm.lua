package.path = package.path .. (";" .. os.getenv("HOME") .. "/.config/wezterm/?.lua")
local config = dofile(os.getenv("HOME") .. "/.config/wezterm/wezterm.lua")
return config
