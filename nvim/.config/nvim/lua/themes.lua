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
      local opts = {
        highlighter = { auto_enable = true },
        highlight_mode = 'background',
        alpha_show = 'show',
        virtual_pos = 'eol',
      }
      ccc.setup(opts)
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
    opts = {},
    config = function()
      local opts = {
        line_opacity = 0.25,
        set_cursor = true,
        set_cursorline = true,
        set_number = true,
        set_signcolumn = false,
      }
      -- Initial setup
      require('modes').setup(opts)
      vim.o.cmdheight = 0

      -- Autocommand on theme switch
      vim.api.nvim_create_autocmd('OptionSet', {
        pattern = 'background',
        callback = function()
          require('modes').setup(opts)
        end,
      })
    end,
  },
  -- {
  --   'xiyaowong/transparent.nvim',
  -- },
}
