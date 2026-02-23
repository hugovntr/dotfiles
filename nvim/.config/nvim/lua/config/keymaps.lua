--
-- Keymaps
--

local function bind(op, outer_opts)
  outer_opts = vim.tbl_extend('force', { noremap = true, silent = true }, outer_opts or {})

  return function(lhs, rhs, opts)
    opts = vim.tbl_extend('force', outer_opts, opts or {})
    vim.keymap.set(op, lhs, rhs, opts)
  end
end

local map = bind ''
local nvnoremap = bind { 'n', 'v' }
local ninoremap = bind { 'n', 'i' }
local nnoremap = bind 'n'
local vnoremap = bind 'v'
local xnoremap = bind 'x'
local inoremap = bind 'i'
local tnoremap = bind 't'

-- Clear highlights when pressing <Esc>
nnoremap('<esc><esc>', '<cmd>nohlsearch<cr>')

-- Diagnostics Keymaps
nnoremap('<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })

-- Save with CMD+S
ninoremap('<M-s>', '<cmd>w<cr><esc><esc>')
-- Save with sd
ninoremap('sdf', '<cmd>w<cr><esc><esc>')

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

-- Change word
nnoremap('cw', '"_ciw') -- Change inside word without copy

-- Buffer management
nnoremap('<C-p>', '<cmd>bprev<cr>', { desc = 'Previous buffer' })
nnoremap('<C-n>', '<cmd>bnext<cr>', { desc = 'Next buffer' })
nnoremap('<leader>q', '<cmd>close<cr>', { silent = false, desc = 'Close current window but keep the buffer open', remap = true })
-- nnoremap('qq', '<cmd>bd<cr>', { silent = true, desc = 'Close current buffer' })

-- One hand fast travel
-- nnoremap('¬', '}') -- down (Alt + L)
-- nnoremap('ø', '{') -- up
-- nnoremap('È', '{') -- up

-- Split pane
nnoremap('<leader>wv', '<cmd>vsplit<cr>')
nnoremap('<leader>wh', '<cmd>split<cr>')
nnoremap('<leader>wx', '<cmd>q<cr>')

-- Insert mode sugar
inoremap('<M-BS>', '<C-W>', { desc = 'Delete previous word' })

-- Move lines
nnoremap('<M-k>', '<cmd>m .-2<cr>', { desc = 'Move line up (1)' })
nnoremap('<M-l>', '<cmd>m .+1<cr>', { desc = 'Move line down (1)' })

-- Move selected line(s) in Visual mode
vnoremap('L', ":m '>+1<CR>gv=gv")
vnoremap('K', ":m '<-2<CR>gv=gv")

-- terminal navigation
-- tnoremap('<Esc>', '<C-\\><C-n>') -- Back to normal mode on ESC
tnoremap('<A-j>', '<C-\\><C-n><C-w>h') -- Exit left
tnoremap('<A-m>', '<C-\\><C-n><C-w>l') -- Exit right
tnoremap('<A-k>', '<C-\\><C-n><C-w>k') -- Exit top
tnoremap('<A-l>', '<C-\\><C-n><C-w>j') -- Exit bottom

-- Reload current file
-- nnoremap('<C-r>', '<cmd>source %<cr>', { desc = '[R]eload current file' })

-- Restart LSP (free the RAM gremlins)
nnoremap('<leader>rl', '<cmd>LspRestart<cr>', { desc = '[R]estart [L]SP' })
