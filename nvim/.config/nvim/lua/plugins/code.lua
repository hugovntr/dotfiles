return {
  -- Code completion
  { -- Blink
    'saghen/blink.cmp',
    dependencies = {
      'rafamadriz/friendly-snippets',
      'onsails/lspkind.nvim',
      { 'xzbdmw/colorful-menu.nvim' },
      { 'L3MON4D3/LuaSnip', version = 'v2.*' },
    },
    version = '*',
    event = 'InsertEnter',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {},
    config = function()
      require 'plugins.config.blink'

      -- capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities(capabilities))
      vim.lsp.config('*', {
        capabilities = capabilities,
      })
    end,
  },

  -- Autoclose and Autorename HTML tags
  {
    'windwp/nvim-ts-autotag',
    event = 'VeryLazy',
    opts = {},
  },

  -- Autopairs characters
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
    config = function()
      -- If you want to automatically add `(` after selecting a function or method
      -- local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      -- local cmp = require 'cmp'
      -- cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },

  -- Code comments
  { 'folke/ts-comments.nvim', event = 'VeryLazy', opts = {} },
  { 'folke/todo-comments.nvim', event = 'VeryLazy', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  -- Code formatter
  {
    'mhartington/formatter.nvim',
    event = 'VeryLazy',
    config = function()
      vim.api.nvim_create_augroup('__formatter__', { clear = true })
      vim.api.nvim_create_autocmd('BufWritePost', {
        group = '__formatter__',
        command = ':FormatWrite',
      })
      require('formatter').setup {
        filetype = {
          lua = { require('formatter.filetypes.lua').stylua },
          typescript = { require('formatter.filetypes.typescript').biome },
          typescriptreact = { require('formatter.filetypes.typescriptreact').biome },
          javascript = { require('formatter.filetypes.javascript').biome },
          javascriptreact = { require('formatter.filetypes.javascriptreact').biome },
          json = { require('formatter.filetypes.json').biome },
          rust = { require('formatter.filetypes.rust').rustfmt },
          python = { require('formatter.filetypes.python').ruff },
        },
      }
    end,
  },

  -- Code linter
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'

      lint.linters_by_ft = {
        javascript = { 'eslint_d' },
        typescript = { 'eslint_d' },
        javascriptreact = { 'eslint_d' },
        typescriptreact = { 'eslint_d' },
      }

      vim.api.nvim_create_augroup('__lint__', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = '__lint__',
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },

  -- SQL UI
  {
    'kristijanhusak/vim-dadbod-ui',
    event = 'VeryLazy',
    dependencies = {
      { 'tpope/vim-dadbod', lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1

      vim.keymap.set('n', '<leader>db', '<cmd>DBUIToggle<cr>', { desc = '[D]ata[b]ase UI', silent = true })
    end,
  },

  -- Search and Replace
  {
    'nvim-pack/nvim-spectre',
    event = 'VeryLazy',
    config = function()
      require 'plugins.config.spectre'
    end,
  },

  -- Diagnostics
  {
    'folke/trouble.nvim',
    event = 'VeryLazy',
    opts = {
      focus = true,
    },
    cmd = 'Trouble',
    keys = {
      { '<leader>t', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)' },
    },
  },
}
