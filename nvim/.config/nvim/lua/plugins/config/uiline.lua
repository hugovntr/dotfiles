local M = {}

M.config = function()
  for hl_name, _ in pairs(vim.api.nvim_get_hl(0, {})) do
    if hl_name:match 'BufferLine*' or hl_name:match 'Slimline*' then
      vim.cmd('hi clear ' .. hl_name)
    end
  end

  --
  -- TOP LINE
  --
  vim.o.termguicolors = true
  require('bufferline').setup {
    options = {
      mode = 'buffers',
      style_preset = { require('bufferline').style_preset.minimal, require('bufferline').style_preset.no_italic },
      indicator = { style = 'none' },
      hover = { enabled = false },
      show_buffer_close_icons = false,
      separator_style = { '', '' },
      tab_size = 12,
      diagnostics = 'nvim_lsp',
      diagnostics_indicator = function(_, _, diag)
        local icons = LazyVim.config.icons.diagnostics
        local ret = (diag.error and icons.Error .. diag.error .. ' ' or '') .. (diag.warning and icons.Warn .. diag.warning or '')
        return vim.trim(ret)
      end,
    },
  }

  vim.keymap.set('n', '<C-n>', '<cmd>BufferLineCycleNext<cr>', { noremap = true })
  vim.keymap.set('n', '<C-p>', '<cmd>BufferLineCyclePrev<cr>', { noremap = true })
  vim.keymap.set('n', '<leader>bp', '<cmd>BufferLineMovePrev<cr>', { desc = 'Move [B]uffer [P]rev', noremap = true })
  vim.keymap.set('n', '<leader>bn', '<cmd>BufferLineMoveNext<cr>', { desc = 'Move [B]uffer [N]ext', noremap = true })
  for i = 1, 9 do
    vim.keymap.set('n', '' .. i .. '', '<cmd>BufferLineGoTo ' .. i .. '<cr>', { silent = true, noremap = true })
  end
  vim.keymap.set('n', '0', '<cmd>BufferLineGoTo -1<cr>', { silent = true })

  --
  -- BOTTOM LINE
  --
  require('slimline').setup {
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
        first = true, -- hides the first separator of the line
        last = true, -- hides the last separator of the line
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
end

M.config()
vim.api.nvim_create_autocmd('OptionSet', {
  pattern = 'background',
  callback = function()
    M.config()
  end,
  desc = 'Switch UI Line variant when background changes',
})
