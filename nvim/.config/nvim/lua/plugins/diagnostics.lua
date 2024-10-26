return {
  {
    'folke/trouble.nvim',
    event = 'BufEnter',
    opts = {
      focus = true,
    },
    cmd = 'Trouble',
    keys = {
      { '<C-ù>', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)' },
    },
  },
}
