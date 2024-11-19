return {
  {
    'folke/trouble.nvim',
    event = 'VeryLazy',
    opts = {
      focus = true,
    },
    cmd = 'Trouble',
    keys = {
      { '<C-,>', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)' },
    },
  },
}
