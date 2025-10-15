local M = {}

M.config = {
  variant = 'light',
  disable = {
    background = false,
    terminal_colors = true,
  },
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

function M.base_init()
  local theme = require 'forest-night'

  theme.setup(M.config)

  local config = theme.get_config()
  local colors = {
    -- Base colors
    bg = '#f5f3ed',
    fg = '#2d3640',

    -- UI colors
    bg_alt = '#eae7dc',
    bg_highlight = '#d4cfc2',
    bg_visual = '#d4e4d8',
    border = '#c9c4b5',

    -- Syntax colors
    comment = '#8a8570',
    comment_alt = '#6a6550',

    -- Functions and methods
    func = '#7d3c98',
    func_builtin = '#7d3c98',

    -- Strings
    string = '#2a9d95',
    string_template = '#2a9d95',
    string_escape = '#c67c0e',
    string_regex = '#a15d4a',

    -- Keywords and control flow
    keyword = '#c67c0e',

    -- Types and classes
    type = '#a15d4a',

    -- Constants and numbers
    constant = '#4a7c5f',
    number = '#4a7c5f',
    boolean = '#4a7c5f',

    -- Variables and properties
    variable = '#2d3640',
    property = '#2a9d95',

    -- Operators and punctuation
    operator = '#2d3640',
    punctuation = '#5a6b78',

    -- Special colors
    cursor = '#3a6b7a',
    line_number = '#8a8570',
    line_number_active = '#3a6b7a',

    -- Diagnostic colors
    error = '#c4432d',
    warning = '#c67c0e',
    info = '#2a9d95',
    hint = '#4a7c5f',

    -- Git colors
    git_add = '#4a7c5f',
    git_change = '#c67c0e',
    git_delete = '#c4432d',
    git_ignore = '#8a8570',

    -- Terminal colors
    terminal_black = '#2d3640',
    terminal_red = '#c41e52',
    terminal_green = '#4a7c5f',
    terminal_yellow = '#c67c0e',
    terminal_blue = '#2a9d95',
    terminal_magenta = '#7d3c98',
    terminal_cyan = '#2a9d95',
    terminal_white = '#768390',
    terminal_bright_black = '#5a6b78',
    terminal_bright_red = '#c41e52',
    terminal_bright_green = '#4a7c5f',
    terminal_bright_yellow = '#c67c0e',
    terminal_bright_blue = '#2a9d95',
    terminal_bright_magenta = '#7d3c98',
    terminal_bright_cyan = '#2a9d95',
    terminal_bright_white = '#2d3640',

    -- Additional colors
    none = 'NONE',
  }

  -- Set colorsheme name
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
  hl('SnacksIndent', { fg = colors.bg_highlight })
end

function M.setup(user_config)
  if user_config then
    M.config = vim.tbl_deep_extend('force', M.config, user_config)
  end
end

function M.load()
  -- Clear existing highlights
  vim.cmd 'hi clear'
  if vim.fn.exists 'syntax_on' then
    vim.cmd 'syntax reset'
  end

  -- Set what's needed
  vim.o.background = 'light'
  vim.g.colors_name = 'forest-light'

  M.setup()
  M.base_init()
end

function M.get_config()
  return M.config
end

M.load()
return M
