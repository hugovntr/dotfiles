return {
  {
    'folke/snacks.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require 'custom.snacks'
    end,
  },
}
