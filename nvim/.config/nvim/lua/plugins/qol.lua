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
      require 'custom.snacks'
    end,
  },

  -- File navigation
  {
    'stevearc/oil.nvim',
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    opts = {},
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
      require 'custom.oil'
    end,
  },

  -- Shortcut helper
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      defer = function(ctx)
        if vim.list_contains({ 'd', 'y' }, ctx.operator) then
          return true
        end
        return vim.list_contains({ '<C-V>', 'V' }, ctx.mode)
      end,
    },
  },

  -- Alternative file navigation + Fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
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
      { 'echasnovski/mini.icons', enabled = vim.g.have_nerd_font },
      { 'nvim-pack/nvim-spectre' },
    },
    config = function()
      require 'custom.telescope'
    end,
  },

  -- Top + Bottom line
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = {
      { 'echasnovski/mini.icons', opts = {} },
      'folke/noice.nvim',
      { 'sschleemilch/slimline.nvim', event = 'VeryLazy' },
    },
    config = function()
      require('mini.icons').setup()
      require('mini.icons').mock_nvim_web_devicons()
      require 'custom.lualine'
    end,
  },

  -- Git signs on gutter
  {
    'lewis6991/gitsigns.nvim',
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
