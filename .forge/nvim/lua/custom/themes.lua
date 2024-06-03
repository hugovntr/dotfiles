-- local c = require 'catppuccin.palettes.mocha'

---@type CtpColors<string>
local color_overrides = {
  base = '#171717',
  green = '#5eff6c',
  red = '#fd5e3a',
  yellow = '#f1ff5e',
  blue = '#5ea1ff',
  mauve = '#bd5eff',
  sky = '#5ef1ff',
  maroon = '#fa7a61',
}

---@param colors CtpColors<string>
local custom_highlights = function(colors)
  return {
    FloatBorder = { fg = colors.surface2, bg = colors.none },
    CmpItemMenu = { style = { 'bold' } },
    TelescopeBorder = {
      fg = colors.surface2,
      bg = colors.none,
    },
    TelescopeMatching = { fg = colors.yellow },
    TelescopeNormal = {
      bg = colors.none,
    },
    TelescopePromptBorder = {
      fg = colors.surface2,
      bg = colors.none,
    },
    TelescopePromptNormal = {
      fg = colors.text,
      bg = colors.none,
    },
    TelescopePromptPrefix = {
      fg = colors.flamingo,
      bg = colors.none,
    },
    TelescopePreviewTitle = {
      fg = colors.base,
      bg = colors.green,
    },
    TelescopePreviewNormal = {
      bg = colors.base,
    },
    TelescopePreviewBorder = {
      fg = colors.base,
      bg = colors.base,
    },
    TelescopePromptTitle = {
      fg = colors.base,
      bg = colors.red,
    },
    TelescopeResultsTitle = {
      fg = colors.mantle,
      bg = colors.lavender,
    },
    TelescopeSelection = {
      fg = colors.text,
      bg = colors.base,
      style = { 'bold' },
    },
    TelescopeSelectionCaret = { fg = colors.flamingo, style = { 'bold' } },
  }
end
require('catppuccin').setup {
  transparent_background = true,
  color_overrides = {
    all = color_overrides,
  },
  custom_highlights = function(colors)
    return custom_highlights(colors)
  end,
  integrations = {
    cmp = true,
    fidget = true,
    telescope = {
      enabled = true,
      -- style = 'nvchad',
    },
    native_lsp = {
      enabled = true,
    },
    notify = true,
    treesitter = true,
  },
  term_colors = true,
}
vim.o.termguicolors = true
local ok, _ = pcall(vim.cmd.colorscheme, 'catppuccin-mocha')
if not ok then
  vim.cmd 'colorscheme default'
end
