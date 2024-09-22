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
    opts = {
      line_opacity = 0.25,
    },
  },
  -- {
  --   'xiyaowong/transparent.nvim',
  -- },
}
