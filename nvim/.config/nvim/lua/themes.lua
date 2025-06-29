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
      }
    end,
  },
  {
    'catppuccin/nvim',
    priority = 1000,
    config = function()
      require 'custom.themes'
    end,
  },
  {
    'mvllow/modes.nvim',
    event = 'BufEnter',
    opts = {
      line_opacity = 0.25,
    },
  },
  -- {
  --   'xiyaowong/transparent.nvim',
  -- },
}
