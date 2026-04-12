local oil = require 'oil'

-- Store the float window id and dimensions for title updates
local oil_float_win = nil
local oil_float_config = nil

oil.setup {
  columns = {
    { 'size', highlight = 'Conceal' },
    { 'icon', add_padding = true },
  },
  win_options = {
    cursorcolumn = false,
    list = false,
    spell = false,
    signcolumn = 'yes',
  },
  delete_to_trash = true,
  view_options = {
    show_hidden = true,
    is_hidden_file = function(name, _)
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
    update_on_cursor_moved = true,
  },
  float = {
    padding = 0,
    max_width = 120,
    max_height = 24,
    border = 'rounded',
    preview_split = 'right',
    title_pos = 'right',
    win_options = {
      winblend = 0,
    },
    override = function(conf)
      return conf
    end,
  },
}

local function is_oil()
  local bufname = vim.fn.bufname ''
  return vim.startswith(bufname, 'oil://')
end

-- Update float title with current Oil directory
local function update_float_title()
  if oil_float_win and vim.api.nvim_win_is_valid(oil_float_win) and oil_float_config then
    local dir = oil.get_current_dir()
    if dir then
      local title = ' ' .. vim.fn.fnamemodify(dir, ':~'):gsub('/$', '') .. ' '
      vim.api.nvim_win_set_config(oil_float_win, {
        relative = 'editor',
        row = oil_float_config.row,
        col = oil_float_config.col,
        width = oil_float_config.width,
        height = oil_float_config.height,
        title = title,
        title_pos = oil_float_config.title_pos,
      })
    end
  end
end

local function toggle_oil()
  if is_oil() then
    oil.close()
    oil_float_win = nil
    oil_float_config = nil
  else
    -- Capture file info BEFORE doing anything else
    local current_buf = vim.api.nvim_get_current_buf()
    local current_file = vim.api.nvim_buf_get_name(current_buf)
    local has_file = current_file ~= '' and not vim.startswith(current_file, 'oil://') and vim.fn.filereadable(current_file) == 1

    -- Get directory for the title
    local dir = has_file and vim.fn.fnamemodify(current_file, ':h') or vim.fn.getcwd()

    -- Create a scratch buffer
    local buf = vim.api.nvim_create_buf(false, true)

    -- Calculate centered float dimensions
    local width = math.min(120, vim.o.columns - 4)
    local height = math.min(24, vim.o.lines - 4)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    -- Store config for later title updates
    oil_float_config = { row = row, col = col, width = width, height = height, title_pos = 'center' }

    -- Open float with the blank buffer
    local win = vim.api.nvim_open_win(buf, true, {
      relative = 'editor',
      row = oil_float_config.row,
      col = oil_float_config.col,
      width = oil_float_config.width,
      height = oil_float_config.height,
      style = 'minimal',
      border = 'rounded',
      title = ' ' .. vim.fn.fnamemodify(dir, ':~') .. ' ',
      title_pos = oil_float_config.title_pos,
      noautocmd = true,
    })

    oil_float_win = win
    vim.w[win].is_oil_win = true

    -- Open Oil in the captured directory
    vim.schedule(function()
      oil.open(dir)
    end)
  end
end

-- Auto-update title when navigating in Oil (covers entering new dirs)
vim.api.nvim_create_autocmd('User', {
  pattern = 'OilEnter',
  callback = vim.schedule_wrap(function()
    update_float_title()
  end),
})

-- Also update title on BufEnter for oil buffers (covers going back)
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = 'oil://*',
  callback = vim.schedule_wrap(function()
    update_float_title()
  end),
})

-- Toggle oil with Meta + E
vim.keymap.set('n', '<M-e>', toggle_oil)
vim.keymap.set('n', '<C-e>', toggle_oil)

-- Close oil with Esc only if Oil is open
vim.keymap.set('n', '<Esc>', function()
  if is_oil() then
    oil.close()
    oil_float_win = nil
    --oil_float_config = nil
  end
end)
