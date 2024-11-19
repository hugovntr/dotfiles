local snacks = require 'snacks'

snacks.setup {
  bigfile = { enabled = true },
  notifier = { enabled = false },
  gitbrowse = { enabled = false },
  statuscolumn = {
    enabled = true,
    left = { 'mark', 'sign' },
    right = { 'fold', 'git' },
    folds = {
      open = false,
      git_hl = false,
    },
    git = {
      patterns = { 'GitSign', 'MiniDiffSign' },
    },
    refresh = 50,
  },
  dashboard = {
    enabled = true,
    width = 80,
    sections = {
      { section = 'header' },
      { section = 'keys', gap = 1, padding = 1 },
      { pane = 2, icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
      { pane = 2, icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
      {
        pane = 2,
        icon = ' ',
        title = 'Git Status',
        section = 'terminal',
        enabled = vim.fn.isdirectory '.git' == 1,
        cmd = 'git status --short --branch --renames',
        height = 5,
        padding = 1,
        ttl = 5 * 60,
        indent = 3,
      },
      { section = 'startup' },
    },
  },
}
vim.keymap.set('n', 'qq', function()
  Snacks.bufdelete()
end, { desc = 'Delete a buffer without disrupting the layout' })
