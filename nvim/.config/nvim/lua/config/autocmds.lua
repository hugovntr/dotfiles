local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

-- Insert mode when entering terminal
vim.api.nvim_create_autocmd('BufEnter', {
  group = augroup 'terminal_insert_on_enter',
  callback = function(event)
    local buf = event.buf
    if vim.bo[buf].buftype == 'terminal' then
      vim.cmd [[ startinsert ]]
    end
  end,
})
