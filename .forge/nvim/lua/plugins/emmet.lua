return {
  {
    'mattn/emmet-vim',
    opts = {},
    config = function()
      vim.keymap.set('n', '<Tab>', '<plug>(emmet-expand-abbr)')
    end,
  },
}
