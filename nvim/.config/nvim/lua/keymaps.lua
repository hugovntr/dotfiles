local nnoremap = require('keymaps_utils').nnoremap
local nvnoremap = require('keymaps_utils').nvnoremap
local inoremap = require('keymaps_utils').inoremap
local ninoremap = require('keymaps_utils').ninoremap

-- Clear highlights when pressing <Esc>
nnoremap('<esc><esc>', '<cmd>nohlsearch<cr>')

-- inlay hints
nnoremap('<leader>i', vim.lsp.inlay_hint.enable, { desc = 'Show [I]nlay Hints' })

-- Diagnostics Keymaps
nnoremap('<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })

-- Save with CMD+S
ninoremap('<M-s>', '<cmd>w<cr><esc><esc>')

-- Exit insert mode with jk
inoremap('jk', '<esc><esc>')
inoremap('kl', '<esc><esc>')

-- Save and Quit
nnoremap('<leader>sq', '<cmd>wqa<cr>', { silent = true })

-- Switch 'j' and 'k'
nvnoremap('j', 'h')
nvnoremap('k', 'gk') -- Remap to display line navigation
nvnoremap('l', 'gj') -- Remap to display line navigation
nvnoremap('m', 'l')

-- 'U' to redo
nnoremap('U', '<C-r>')

-- Cut using x
nvnoremap('x', 'd')
nvnoremap('xx', 'dd')

-- Delete without copy
nvnoremap('d', '"_d')
nvnoremap('dd', '"_dd')

-- Buffer management
nnoremap('<C-p>', '<cmd>bprev<cr>', { desc = 'Previous buffer' })
nnoremap('<C-n>', '<cmd>bnext<cr>', { desc = 'Next buffer' })
nnoremap('<leader>q', '<cmd>bd<cr>', { silent = false, desc = 'Close current buffer' })
nnoremap('qq', '<cmd>bd<cr>', { silent = true, desc = 'Close current buffer' })

-- One hand fast travel
nnoremap('¬', '}') -- down (Alt + L)
nnoremap('ø', '{') -- up
nnoremap('È', '{') -- up

-- Split pane
nnoremap('<leader>wv', '<cmd>vsplit<cr>')
nnoremap('<leader>wh', '<cmd>split<cr>')
nnoremap('<leader>wx', '<cmd>q<cr>')

-- Insert mode sugar
inoremap('<M-BS>', '<C-W>', { desc = 'Delete previous word' })

-- Move lines
nnoremap('<M-k>', '<cmd>m .-2<cr>', { desc = 'Move line up (1)' })
nnoremap('<M-l>', '<cmd>m .+1<cr>', { desc = 'Move line down (1)' })

-- Reload current file
nnoremap('<C-r>', '<cmd>source %<cr>', { desc = '[R]eload current file' })
