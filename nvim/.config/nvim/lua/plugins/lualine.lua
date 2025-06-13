return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = {
    { 'echasnovski/mini.icons', opts = {} },
    -- {
    --   'utilyre/barbecue.nvim',
    --   event = 'VeryLazy',
    --   dependencies = {
    --     'SmiteshP/nvim-navic',
    --   },
    --   opts = {
    --     attach_navic = false,
    --     create_autocmd = false,
    --   },
    -- },
    'folke/noice.nvim',
  },
  config = function()
    require('mini.icons').setup()
    require('mini.icons').mock_nvim_web_devicons()
    require 'custom.lualine'
  end,
}
