local snacks = require 'snacks'
local ascii = require 'ascii'

snacks.setup {
  image = { enabled = true },
  bigfile = { enabled = true },
  notifier = { enabled = true, style = 'minimal', top_down = true },
  indent = {
    enabled = true,
    scope = { enabled = true, only_current = true, priority = 200 },
    chunk = { enabled = true, only_current = true, priority = 200, char = { arrow = '─' } },
  },
  gitbrowse = { enabled = false },
  statuscolumn = {
    enabled = true,
    left = { 'mark', 'sign' },
    right = { 'fold', 'git' },
    folds = {
      open = true,
      git_hl = false,
    },
    -- git = {
    --   patterns = { 'GitSign', 'MiniDiffSign' },
    -- },
    refresh = 200,
  },
  dashboard = {
    enabled = true,
    width = 80,
    preset = {
      header = table.concat(ascii.art.text.neovim.sharp, '\n'),
    },
    sections = {
      { section = 'header', height = 90 },
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
  -- scroll = {
  --   enabled = true,
  --   animate = {
  --     duration = { step = 15, total = 250 },
  --     easing = 'linear',
  --     fps = 120,
  --   },
  --   -- faster animation when repeating scroll after delay
  --   animate_repeat = {
  --     delay = 100, -- delay in ms before using the repeat animation
  --     duration = { step = 5, total = 50 },
  --     easing = 'linear',
  --     fps = 120,
  --   },
  --   -- what buffers to animate
  --   filter = function(buf)
  --     return vim.g.snacks_scroll ~= false and vim.b[buf].snacks_scroll ~= false and vim.bo[buf].buftype ~= 'terminal'
  --   end,
  -- },
  -- animate = {
  --   duration = 20,
  --   easing = 'linear',
  --   fps = 120,
  -- },
}
vim.keymap.set('n', 'qq', function()
  Snacks.bufdelete()
end, { desc = 'Delete a buffer without disrupting the layout' })
