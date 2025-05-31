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
    dependencies = {
      {
        'aaronik/treewalker.nvim',
        event = 'VeryLazy',
        opts = {
          highlight = false,
          highlight_duration = 250,
          highlight_group = 'CursorLine',
          jumplist = true,
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
