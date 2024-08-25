return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    {
      'utilyre/barbecue.nvim',
      dependencies = {
        'SmiteshP/nvim-navic',
      },
      opts = {},
    },
    'folke/noice.nvim',
  },
  config = function()
    require 'custom.lualine'
  end,
}
