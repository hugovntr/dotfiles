local colors = {
  blue = '#80a0ff',
  cyan = '#79dac8',
  black = '#080808',
  white = '#c6c6c6',
  red = '#ff5189',
  violet = '#d183e8',
  grey = '#303030',
}

local theme = {
  normal = {
    a = { fg = 'Gray', gui = 'bold' },
    b = { fg = colors.violet },
    c = { fg = 'Cyan' },
    x = { fg = 'LightGray' },
    y = { fg = colors.red },
  },
  insert = {
    a = { fg = 'LightGreen', gui = 'bold' },
  },
  visual = {
    a = { fg = 'LightMagenta', gui = 'bold' },
  },
  inactive = {
    z = { fg = 'Gray' },
  },
}

local function ollama_status()
  if package.loaded['ollama'] == nil then
    return nil
  end
  if require('ollama').status() == nil then
    return nil
  end

  if vim.g.ollama_started == nil or vim.g.ollama_started == false then
    return '  Ollama'
  else
    return '  Ollama'
  end
end

require('lualine').setup {
  options = {
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    icons_enabled = true,
    theme = theme,
  },
  tabline = {
    lualine_a = {
      {
        'buffers',
        mode = 0,
        show_filename_only = true,
        use_mode_colors = false,
        symbols = { alternate_file = '' },
        filetype_names = { oil = 'File Explorer' },
        buffers_color = {
          inactive = { fg = '#777777', bg = '' },
          active = { fg = 'White', gui = 'bold' },
        },
      },
    },
    lualine_b = { 'diff' },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {
      {
        'datetime',
        style = '%H:%M',
        color = { fg = '#FF4F00' },
        fmt = function(string)
          return '  ' .. string
        end,
      },
    },
  },
  sections = {
    lualine_a = {
      {
        'mode',
        separator = nil,
        right_padding = 2,
        icons_enabled = true,
        icon = '󰧚 ',
      },
    },
    lualine_b = { 'branch' },
    lualine_c = {
      'diagnostics',
      -- function()
      --   local entries = require('barbecue.ui.state').get_entries(vim.current.window)
      --   local winbar = '%#BarbecueNormal# '
      --   if entries == nil then
      --     return 'Nothing'
      --   end
      --   for i, entry in ipairs(entries) do
      --     winbar = winbar .. entry:to_string()
      --     if i < #entries then
      --       winbar = winbar .. '%#BarbecueNormal# %#BarbecueSeparator#' .. '%#BarbecueNormal# '
      --     end
      --   end
      --   print(winbar)
      --   return winbar
      -- end,
    },
    lualine_d = { '%=' },
    lualine_x = { 'filetype' },
    lualine_y = {
      {
        'location',
        separator = { --[[ right = '' ]]
        },
        left_padding = 2,
      },
    },
    lualine_z = {
      {
        ollama_status,
        cond = nil,
        color = { fg = 'Gray' },
      },
    },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  extensions = {
    'neo-tree',
  },
}
