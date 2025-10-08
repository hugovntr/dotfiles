return {
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
}
