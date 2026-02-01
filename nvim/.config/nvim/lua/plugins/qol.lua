return {
  -- Splashscreen
  -- Status column
  -- Image
  -- Bigfile
  -- Notifier
  {
    'folke/snacks.nvim',
    lazy = false,
    priority = 1000,
    dependencies = {
      {
        'MaximilianLloyd/ascii.nvim',
        dependencies = {
          'MunifTanjim/nui.nvim',
        },
      },
    },
    config = function()
      require 'plugins.config.snacks'
    end,
  },

  -- File navigation
  {
    'stevearc/oil.nvim',
    dependencies = { { 'nvim-mini/mini.icons', opts = {} } },
    lazy = true,
    event = 'VeryLazy',
    config = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'oil',
        callback = function()
          vim.opt_local.colorcolumn = ''
          vim.opt_local.relativenumber = false
          vim.opt_local.number = false
        end,
      })
      require 'plugins.config.oil'
    end,
  },

  -- Shortcut helper
  {
    'folke/which-key.nvim',
    lazy = true,
    event = 'VeryLazy',
    opts = {
      defer = function(ctx)
        if vim.list_contains({ 'd', 'y' }, ctx.operator) then
          return true
        end
        return vim.list_contains({ '<C-V>', 'V' }, ctx.mode)
      end,
      preset = 'modern',
    },
  },

  -- Alternative file navigation + Fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    lazy = true,
    branch = 'master',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-mini/mini.icons', enabled = vim.g.have_nerd_font },
      { 'nvim-pack/nvim-spectre' },
    },
    config = function()
      require 'plugins.config.telescope'
    end,
  },

  -- Git signs on gutter
  {
    'lewis6991/gitsigns.nvim',
    lazy = true,
    event = 'VeryLazy',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
}
