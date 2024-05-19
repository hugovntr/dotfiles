package.path = package.path .. (";" .. os.getenv("HOME") .. "/.forge/wezterm/?.lua")
local config = dofile(os.getenv("HOME") .. "/.forge/wezterm/wezterm.lua")
return config
