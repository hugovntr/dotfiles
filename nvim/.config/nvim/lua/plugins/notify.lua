return {
  {
    'rcarriga/nvim-notify',
    event = 'VeryLazy',
    opts = {},
  },
  -- {
  --   'mrded/nvim-lsp-notify',
  --   config = function()
  --     require('lsp-notify').setup {
  --       notify = require 'notify',
  --     }
  --   end,
  -- },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      presets = {
        lsp_doc_border = true,
      },
      cmdline = {
        enabled = true,
        view = 'cmdline',
      },
      lsp = {
        hover = {
          enabled = true,
          silent = true,
          view = nil,
          opts = {},
        },
      },
      routes = {
        {
          filter = {
            event = 'notify',
            find = 'Request textDocument/inlayHint failed',
          },
          opts = { skip = true },
        },
      },
    },
  },
}
