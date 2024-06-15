-- Navigate between panes
local splits = require 'smart-splits'
vim.keymap.set('n', '<C-m>', splits.move_cursor_right)
vim.keymap.set('n', '<C-j>', splits.move_cursor_left)
vim.keymap.set('n', '<C-k>', splits.move_cursor_up)
vim.keymap.set('n', '<C-l>', splits.move_cursor_down)
