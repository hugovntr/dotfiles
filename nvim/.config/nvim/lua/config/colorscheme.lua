local M = {}

function M.set_theme(theme)
  -- Clear existing highlights
  vim.cmd 'hi clear'
  if vim.fn.exists 'syntax_on' then
    vim.cmd 'syntax reset'
  end

  if theme == 'light' then
    local light = require 'themes.forest-light'
    light.setup()
    vim.g.colors_name = 'forest-light'
  else
    local dark = require 'themes.forest-night'
    dark.setup()
    vim.g.colors_name = 'forest-night'
  end
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

function M.sync_with_system()
  local system_theme = M.get_system_theme()
  vim.o.background = system_theme
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
  M.sync_with_system()

  -- Set initial theme
  M.set_theme(vim.o.background)

  -- Register manual override command
  vim.keymap.set('n', '<leader>sa', function()
    vim.o.background = vim.o.background == 'light' and 'dark' or 'light'
  end, { desc = '[S]witch [A]ppearance' })

  -- local timer = vim.loop.new_timer()
  -- timer:start(
  --   5000,
  --   5000,
  --   vim.schedule_wrap(function()
  --     M.sync_with_system()
  --   end)
  -- )
  -- Check system theme when Neovim gains focus
  -- NOTE: This doesn't work
  -- vim.api.nvim_create_autocmd({ 'FocusGained' }, {
  --   callback = function()
  --     M.sync_with_system()
  --   end,
  --   desc = 'Sync theme with system',
  -- })
end

return M
