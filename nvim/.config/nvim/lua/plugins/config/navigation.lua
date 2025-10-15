-- Navigate between panes
local splits = require 'smart-splits'
vim.keymap.set('n', '<C-m>', splits.move_cursor_right)
vim.keymap.set('n', '<C-j>', splits.move_cursor_left)
vim.keymap.set('n', '<C-k>', splits.move_cursor_up)
vim.keymap.set('n', '<C-l>', splits.move_cursor_down)

-- Treewalker
vim.keymap.set('n', '¬', '<cmd>Treewalker Down<cr>') -- down
vim.keymap.set('n', 'ø', '<cmd>Treewalker Up<cr>') -- up
vim.keymap.set('n', 'È', '<cmd>Treewalker Up<cr>') -- up
vim.keymap.set('n', 'Ï', '<cmd>Treewalker Left<cr>') -- left
vim.keymap.set('n', 'µ', '<cmd>Treewalker Right<cr>') -- left

vim.keymap.set('n', 'Í', '<cmd>Treewalker SwapLeft<cr>') -- left
vim.keymap.set('n', 'Ë', '<cmd>Treewalker SwapUp<cr>') -- up
vim.keymap.set('n', '|', '<cmd>Treewalker SwapDown<cr>') -- down
vim.keymap.set('n', 'Ó', '<cmd>Treewalker SwapRight<cr>') -- right
