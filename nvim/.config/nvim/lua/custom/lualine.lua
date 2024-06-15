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
    z = { fg = 'Yellow' },
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

require('lualine').setup {
  options = {
    component_separators = '',
    icons_enabled = true,
    theme = theme,
  },
  tabline = {
    lualine_a = {
      {
        'buffers',
        mode = 0,
        show_filename_only = true,
        use_mode_colors = true,
        symbols = { alternate_file = '' },
        buffers_color = {
          inactive = 'lualine_a_normal',
          active = 'lualine_a_insert',
        },
      },
    },
    lualine_b = { 'diff' },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {
      'datetime',
    },
  },
  sections = {
    lualine_a = {
      {
        'mode',
        separator = { --[[ left = '' ]]
        },
        right_padding = 2,
        icons_enabled = true,
        icon = '󰧚 ',
      },
    },
    lualine_b = { 'branch' },
    lualine_c = { 'diagnostics' },
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
    lualine_z = {},
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
