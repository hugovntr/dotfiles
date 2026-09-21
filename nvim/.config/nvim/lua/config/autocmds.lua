-- local function augroup(name)
--   return vim.api.nvim_create_augroup(name, { clear = true })
-- end

-- Insert mode when entering terminal
-- vim.api.nvim_create_autocmd('BufEnter', {
--   group = augroup 'terminal_insert_on_enter',
--   callback = function(event)
--     local buf = event.buf
--     if vim.bo[buf].buftype == 'terminal' then
--       vim.cmd [[ startinsert ]]
--     end
--   end,
-- })

-- Open help in vertical split
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'help',
  command = 'wincmd L',
})

-- Resize splits when vim gets resized
vim.api.nvim_create_autocmd('VimResized', {
  command = 'wincmd =',
})

-- Disable automatic comment insertion on new line
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  command = 'set formatoptions-=o',
})

-- Disable Neovim's built-in markdown markup conceal.
-- The bundled syntax/mkd.vim forces 'conceallevel = 2' for markdown files,
-- which hides the markup around emphasis (e.g. '**bold**' renders as bold
-- text with the asterisks hidden). This causes the line width to shift as
-- the cursor moves over the line. Turn it off only for markdown filetypes.
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    -- 'opt_local' so this only affects markdown buffers, not other filetypes.
    vim.opt_local.conceallevel = 0
  end,
})
