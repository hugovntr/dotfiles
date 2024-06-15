return {
  {
    'folke/trouble.nvim',
    event = 'BufEnter',
    opts = {
      focus = true,
    },
    cmd = 'Trouble',
    keys = {
      { '<C-g>', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)' },
    },
  },
}
