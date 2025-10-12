local lualine = require 'lualine'
local slimline = require 'slimline'
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

lualine.setup {
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
          active = { fg = 'Foreground', gui = 'bold' },
        },
        fmt = function(bufname, ctx)
          if ctx.file:match '.*/app.*/page.tsx' then
            return ctx.file:gsub('(.*/)(.*)/page.[j|t]sx', '%2') .. ' - page.tsx'
          end
          if ctx.file:match '.*/app.*/layout.tsx' then
            return ctx.file:gsub('(.*/)(.*)/layout.[j|t]sx', '%2') .. ' - layout.tsx'
          end
          return bufname
        end,
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
    lualine_x = {
      {
        ---@diagnostic disable-next-line: undefined-field
        require('noice').api.status.command.get,
        ---@diagnostic disable-next-line: undefined-field
        cond = require('noice').api.status.command.has,
        color = { fg = '#ff9e64' },
      },
      {
        ---@diagnostic disable-next-line: undefined-field
        require('noice').api.status.mode.get,
        ---@diagnostic disable-next-line: undefined-field
        cond = require('noice').api.status.mode.has,
        color = { fg = '#ff9e64' },
      },
      {
        ---@diagnostic disable-next-line: undefined-field
        require('noice').api.status.search.get,
        ---@diagnostic disable-next-line: undefined-field
        cond = require('noice').api.status.search.has,
        color = { fg = '#ff9e64' },
      },
      'filetype',
    },
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
}
lualine.hide { unhide = false, place = { 'statusline' } }
slimline.setup {
  bold = true, -- makes primary parts bold

  -- Global style. Can be overwritten using `configs.<component>.style`
  style = 'fg', -- or "fg"

  -- Component placement
  components = {
    left = {
      'mode',
      'path',
      'diagnostics',
      'git',
    },
    center = {},
    right = {
      'recording',
      'filetype_lsp',
      'progress',
    },
  },

  -- Inactive components
  -- Uses all `components` by default.
  -- E.g. for only showing `path`:
  components_inactive = {
    left = { 'path' },
    right = {},
  },

  -- Component configuration
  -- `<component>.style` can be used to overwrite the global 'style'
  -- `<component>.sep` can be used to overwrite the global 'sep.left' and `sep.right`
  -- `<component>.hl = { primary = ..., secondary = ...}` can be used to overwrite global ones
  -- `<component>.follow` can point to another component name to follow its style (e.g. 'progress' following 'mode' by default). Follow can be disabled by setting it to `false`
  configs = {
    mode = {
      verbose = false, -- Mode as single letter or as a word
      hl = {
        normal = 'Label',
        insert = 'String',
        pending = 'Boolean',
        visual = 'Keyword',
        command = 'String',
      },
    },
    path = {
      directory = true, -- Whether to show the directory
      icons = {
        folder = ' ',
        modified = '',
        read_only = '',
      },
    },
    git = {
      icons = {
        branch = '',
        added = '+',
        modified = '~',
        removed = '-',
      },
      hl = { primary = 'Keyword' },
    },
    diagnostics = {
      workspace = true, -- Whether diagnostics should also show the total amount of workspace diagnostics
      icons = {
        ERROR = ' ',
        WARN = ' ',
        HINT = ' ',
        INFO = ' ',
      },
    },
    filetype_lsp = {
      hl = { primary = 'WarningMsg' },
    },
    progress = {
      follow = 'mode',
      column = true, -- Enables a secondary section with the cursor column
      icon = ' ',
    },
    recording = {
      hl = { primary = 'ErrorMsg' },
      icon = ' ',
    },
  },

  -- Spacing configuration
  spaces = {
    components = ' ', -- string between components
    left = ' ', -- string at the start of the line
    right = ' ', -- string at the end of the line
  },

  -- Seperator configuartion
  sep = {
    hide = {
      first = false, -- hides the first separator of the line
      last = false, -- hides the last separator of the line
    },
    left = '', -- left separator of components
    right = '', -- right separator of components
  },

  -- Global highlights
  hl = {
    base = 'Normal', -- highlight of the background
    primary = 'Normal', -- highlight of primary parts (e.g. filename)
    secondary = 'Comment', -- highlight of secondary parts (e.g. filepath)
  },
}
