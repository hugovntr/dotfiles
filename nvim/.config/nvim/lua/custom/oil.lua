local oil = require 'oil'
oil.setup {
  columns = {
    'icon',
    'size',
  },
  delete_to_trash = true,
  view_options = {
    show_hidden = true,
    if_hidden_file = function(name, _)
      return vim.startswith(name, '.')
    end,
    is_always_hidden = function(name, _)
      return name == '.git' or name == 'node_modules' or name == '..'
    end,
  },
  preview = {
    max_width = 0.9,
    max_height = 0.9,
    width = nil,
    height = nil,
    win_options = {
      winblend = 0,
    },
    update_on_cursor_moved = true,
  },
  float = {
    -- Padding around the floating window
    padding = 2,
    max_width = 120,
    max_height = 24,
    border = 'rounded',
    preview_split = 'auto',
    win_options = {
      winblend = 0,
    },
    -- This is the config that will be passed to nvim_open_win.
    -- Change values here to customize the layout
    override = function(conf)
      return conf
    end,
  },
}

local function is_oil()
  local bufname = vim.fn.bufname ''
  return vim.startswith(bufname, 'oil://')
end

local function toggle_oil()
  local bufname = vim.fn.bufname ''
  if vim.startswith(bufname, 'oil://') then
    oil.close()
  else
    oil.open_float()
    -- vim.wait(1000, function()
    --   return oil.get_cursor_entry() ~= nil
    -- end)
    -- if oil.get_cursor_entry() then
    --   oil.open_preview()
    -- end
  end
end

-- Toggle oil with Meta + E
vim.keymap.set('n', '<M-e>', toggle_oil)
vim.keymap.set('n', '<C-e>', toggle_oil)

-- Autocmd to enable preview
-- vim.api.nvim_create_autocmd('User', {
--   pattern = 'OilEnter',
--   callback = vim.schedule_wrap(function(args)
--     if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then
--       local pw = require('oil.util').get_preview_win()
--       if pw then
--         vim.api.nvim_win_close(pw, true)
--       end
--       oil.open_preview()
--     end
--   end),
-- })

-- Close oil with Esc only if Oil is openned
vim.keymap.set('n', '<Esc>', function()
  if is_oil() then
    oil.close()
  end
end)
