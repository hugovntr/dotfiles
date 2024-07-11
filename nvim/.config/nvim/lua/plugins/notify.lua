return {
  {
    'rcarriga/nvim-notify',
    opts = {},
  },
  {
    'mrded/nvim-lsp-notify',
    config = function()
      require('lsp-notify').setup {
        notify = require 'notify',
      }
    end,
  },
}
