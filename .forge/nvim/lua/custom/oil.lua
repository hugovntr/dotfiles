local oil = require 'oil'
oil.setup {
  columns = {
    'icon',
  },
  view_options = {
    show_hidden = true,
    if_hidden_file = function(name, _)
      return vim.startswith(name, '.')
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
  return bufname:find '^oil://(.*)$'
end

-- Toggle oil with Meta + E
vim.keymap.set('n', '<M-e>', function()
  if is_oil() ~= nil then
    oil.close()
  else
    oil.open()
    require('oil.util').run_after_load(0, function()
      oil.open_preview()
    end)
  end
end)

-- Close oil with Esc only if Oil is openned
vim.keymap.set('n', '<Esc>', function()
  if is_oil() ~= nil then
    oil.close()
  end
end)
