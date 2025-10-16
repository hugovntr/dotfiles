local M = {}

function M.setup()
  local theme = require 'forest-night'

  theme.setup {
    variant = 'dark',
    disable = {
      background = false,
      terminal_colors = true,
    },
    plugins = {
      treesitter = true,
      lsp = true,
      telescope = true,
      blink = true,
      whichkey = true,
      gitsigns = true,
      markdown = true,
      noice = true,
      trouble = true,
      snacks = true,
    },
  }

  local config = theme.get_config()
  local colors = require('forest-night.theme').colors
  config.colors = colors

  -- Apply themes
  require('forest-night.theme').apply(config)
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

function M.load()
  -- Clear existing highlights
  vim.cmd 'hi clear'
  if vim.fn.exists 'syntax_on' then
    vim.cmd 'syntax reset'
  end

  -- Set what's needed
  vim.o.background = 'dark'
  vim.g.colors_name = 'forest-dark'

  M.setup()
end

M.load()
return M
