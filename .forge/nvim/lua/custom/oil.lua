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
-- vim.keymap.set('n', '<M-e>', '<cmd>lua require("oil").toggle_float()<cr>')
vim.keymap.set('n', '<M-e>', function()
  oil.toggle_float()
end)
