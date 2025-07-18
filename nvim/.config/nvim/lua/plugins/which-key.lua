return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    defer = function(ctx)
      if vim.list_contains({ 'd', 'y' }, ctx.operator) then
        return true
      end
      return vim.list_contains({ '<C-V>', 'V' }, ctx.mode)
    end,
  },
}
