local M = {
  state = '',
  light = 'forest-light',
  dark = 'forest-dark',
}

function M.set_theme(theme)
  if theme == 'light' and M.state ~= 'light' then
    vim.cmd('colorscheme ' .. M.light)
  elseif theme == 'dark' and M.state ~= 'dark' then
    vim.cmd('colorscheme ' .. M.dark)
  end
  M.state = theme
end

function M.get_system_theme()
  -- macOS
  local handle = io.popen 'osascript -e \'tell application "System Events" to tell appearance preferences to get dark mode\''
  if handle then
    local r = handle:read '*a'
    handle:close()
    return r:match 'true' and 'dark' or 'light'
  end

  -- Fallback to dark if detection fails
  return 'dark'
end

---@param theme string|nil
function M.sync_with_system(theme)
  local system_theme = theme or M.get_system_theme()
  if system_theme ~= M.state then
    vim.o.background = system_theme
  end
end

function M.setup()
  -- Create autocommand to watch for background changes
  vim.api.nvim_create_autocmd('OptionSet', {
    pattern = 'background',
    callback = function()
      M.set_theme(vim.o.background)
    end,
    desc = 'Switch theme variant when background changes',
  })

  -- Sync with system theme on startup
  --M.sync_with_system()

  -- Set initial theme
  --M.set_theme(vim.o.background)

  -- Register manual override command
  vim.keymap.set('n', '<leader>sa', function()
    vim.o.background = vim.o.background == 'light' and 'dark' or 'light'
  end, { desc = '[S]witch [A]ppearance', remap = false })

  -- Always sync with system
  local stdout = vim.uv.new_pipe(false)
  ---@diagnostic disable-next-line: missing-fields
  local _, pid = vim.uv.spawn('dark-notify', {
    stdio = { nil, stdout, nil },
  }, function() end)

  -- Read whenever a new notification comes in
  ---@diagnostic disable-next-line: param-type-mismatch
  vim.uv.read_start(stdout, function(_, chunk)
    if chunk then
      vim.schedule(function()
        M.sync_with_system(chunk:gsub('%s+', ''))
      end)
    end
  end)

  -- Kill the background process on exit
  vim.api.nvim_create_autocmd('QuitPre', {
    callback = function()
      vim.uv.kill(pid + 0, 9)
    end,
  })
end

return M
