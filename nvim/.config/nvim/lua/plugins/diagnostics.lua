return {
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
