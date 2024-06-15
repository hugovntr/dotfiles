return {
  {
    'rktjmp/lush.nvim',
    event = 'VeryLazy',
  },
  {
    'norcalli/nvim-colorizer.lua',
    event = 'BufEnter',
    opts = { '*' },
  },
  {
    'catppuccin/nvim',
    priority = 1000,
    config = function()
      require 'custom.themes'
    end,
  },
  {
    'xiyaowong/transparent.nvim',
    config = function()
      require('transparent').setup {
        enabled = false,
      }
    end,
  },
}
