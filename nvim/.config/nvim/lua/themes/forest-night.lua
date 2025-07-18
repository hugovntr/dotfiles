local M = {}

function M.setup()
  local theme = require 'forest-night'

  theme.setup {
    variant = 'light',
    disable = {
      background = true,
      terminal_colors = true,
    },
    highlights = {},
    plugins = {
      treesitter = true,
      lsp = true,
      telescope = true,
      nvimtree = false,
      blink = true,
      whichkey = true,
      gitsigns = true,
      indent_blane = false,
      markdown = true,
      noice = true,
      trouble = true,
      snacks = true,
    },
  }

  theme.load()

  local config = theme.get_config()
  local colors = require('forest-night.theme').colors

  require('forest-night.plugins.blink').apply(colors, config)
  require('forest-night.plugins.snacks').apply(colors, config)
  require('forest-night.plugins.trouble').apply(colors, config)
  require('forest-night.plugins.noice').apply(colors, config)
  require('forest-night.plugins.mason').apply(colors, config)
  require('forest-night.plugins.mini').apply(colors, config)
  require('forest-night.plugins.telescope').apply(colors, config)

  local function hl(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hl('BlinkCmpMenu', { fg = colors.fg, bg = colors.bg })
end

return M
