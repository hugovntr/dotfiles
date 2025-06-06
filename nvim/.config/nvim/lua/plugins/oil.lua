vim.api.nvim_create_autocmd('FileType', {
  pattern = 'oil',
  callback = function()
    vim.opt_local.colorcolumn = ''
  end,
})

return {
  {
    'stevearc/oil.nvim',
    -- dependencies = { 'nvim-tree/nvim-web-devicons' },
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    opts = {},
    event = 'VeryLazy',
    config = function()
      require 'custom.oil'
    end,
  },
}
