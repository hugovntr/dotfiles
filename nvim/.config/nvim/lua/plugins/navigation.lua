return {
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
          jumplist = true,
        },
      },
    },
    config = function()
      require 'plugins.config.navigation'
    end,
  },
  {
    'sunaku/tmux-navigate',
  },
}
