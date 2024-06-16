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
  },
  config = function()
    require 'custom.lualine'
  end,
}
