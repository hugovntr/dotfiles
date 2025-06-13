return {
  -- {
  --   'folke/flash.nvim',
  --   event = 'VeryLazy',
  --   ---@type Flash.Config
  --   opts = {},
  --   keys = {
  --     {
  --       '<c-f>',
  --       mode = { 'n', 'x', 'o' },
  --       function()
  --         require('flash').jump()
  --       end,
  --       desc = 'Flash',
  --     },
  --   },
  -- },
  {
    'mrjones2014/smart-splits.nvim',
    event = 'VeryLazy',
    dependencies = {
      {
        'aaronik/treewalker.nvim',
        event = 'VeryLazy',
        opts = {
          highlight = true,
          highlight_duration = 250,
          highlight_group = 'CursorLine',
          jumplist = false,
        },
      },
    },
    config = function()
      require 'custom.navigation'
    end,
  },
  -- {
  --   'nanotee/zoxide.vim',
  --   event = 'VeryLazy',
  --   dependencies = {
  --     {
  --       'junegunn/fzf',
  --     },
  --   },
  -- },
}
