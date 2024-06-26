local oil = require 'oil'
oil.setup {
  columns = {
    'icon',
  },
  delete_to_trash = true,
  view_options = {
    show_hidden = true,
    if_hidden_file = function(name, _)
      return vim.startswith(name, '.')
    end,
    is_always_hidden = function(name, _)
      return name == '.git' or name == 'node_modules'
    end,
  },
  preview = {
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

-- Toggle oil with Meta + E
vim.keymap.set('n', '<M-e>', function()
  if is_oil() then
    oil.close()
  else
    oil.open_float()
  end
end)

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
