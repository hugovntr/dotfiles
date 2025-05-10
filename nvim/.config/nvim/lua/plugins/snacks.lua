return {
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
}
