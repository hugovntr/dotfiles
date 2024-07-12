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
    'mvllow/modes.nvim',
    event = 'BufEnter',
    opts = {},
  },
  -- {
  --   'xiyaowong/transparent.nvim',
  -- },
}
