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
        },
      }
    end,
  },
  -- { -- Autoformat
  --   'stevearc/conform.nvim',
  --   event = 'VeryLazy',
  --   opts = {
  --     notify_on_error = false,
  --     format_on_save = function(bufnr)
  --       -- Disable "format_on_save lsp_fallback" for languages that don't
  --       -- have a well standardized coding style. You can add additional
  --       -- languages here or re-enable it for the disabled ones.
  --       local disable_filetypes = { c = true, cpp = true }
  --       return {
  --         timeout_ms = 500,
  --         lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
  --       }
  --     end,
  --     formatters_by_ft = {
  --       lua = { 'stylua' },
  --       -- Conform can also run multiple formatters sequentially
  --       python = { 'isort', 'ruff' },
  --
  --       -- You can use a sub-list to tell conform to run *until* a formatter
  --       -- is found.
  --       javascript = { { 'biome', 'prettierd', 'prettier' } },
  --     },
  --   },
  -- },
}
