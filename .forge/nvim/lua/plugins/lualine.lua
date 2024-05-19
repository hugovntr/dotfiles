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
    a = { fg = 'gray', gui = 'bold' },
    b = { fg = 'cyan' },
    c = { fg = 'violet' },
    d = { fg = 'white' },
  },
  insert = {
    a = { fg = 'LightGreen', gui = 'bold' },
  },
  visual = {
    a = { fg = 'LightMagenta', gui = 'bold' },
  },
}

return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('lualine').setup {
      options = {
        component_separators = '',
        -- section_separators = { left = '', right = '' },
        -- theme = 'catppuccin',
        theme = theme,
      },
      tabline = {
        lualine_a = { { 'buffers', symbols = { alternate_file = '' }, buffers_color = { inactive = 'lualine_a_normal', active = 'lualine_a_insert' } } },
        lualine_b = { 'diagnostics' },
        lualine_c = { 'diff' },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
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
        lualine_b = { 'filename' },
        lualine_c = { 'branch' },
        lualine_d = { '%=' },
        lualine_x = {},
        lualine_y = { 'filetype', 'progress' },
        lualine_z = {
          {
            'location',
            separator = { --[[ right = '' ]]
            },
            left_padding = 2,
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
  end,
}
