return {
  {
    'rktjmp/lush.nvim',
    event = 'VeryLazy',
  },
  {
    'uga-rosa/ccc.nvim',
    event = 'VeryLazy',
    config = function()
      local ccc = require 'ccc'
      ccc.setup {
        highlighter = { auto_enable = true },
        highlight_mode = 'background',
        alpha_show = 'show',
        virtual_pos = 'eol',
      }
    end,
  },
  {
    'catppuccin/nvim',
    name = 'modppuccin',
    lazy = true,
  },
  {
    'adibhanna/forest-night.nvim',
    lazy = true,
  },
  {
    'mvllow/modes.nvim',
    event = 'BufEnter',
    opts = {
      line_opacity = 0.25,
      set_cursor = true,
      set_cursorline = true,
      set_number = true,
      set_signcolumn = false,
    },
  },
  -- {
  --   'xiyaowong/transparent.nvim',
  -- },
}
