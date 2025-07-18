local M = {}

function M.setup()
  local c = require 'catppuccin.palettes.mocha'

  ---@type CtpColors<string>
  local color_overrides = {
    brand = '#FF4F00',
    base = '#171717',
    -- green = '#5eff6c',
    -- red = '#fd5e3a',
    -- yellow = '#f1ff5e',
    -- blue = '#5ea1ff',
    -- mauve = '#bd5eff',
    -- sky = '#5ef1ff',
    -- maroon = '#fa7a61',

    red = '#f43f5e',
    green = '#34d399',
    yellow = '#eab308',
    blue = '#4291FF',
    mauve = '#d946ef',
    sky = '#22d3ee',
    maroon = '#da7635',
  }

  ---@param colors CtpColors<string>
  local custom_highlights = function(colors)
    return {
      NormalFloat = { bg = colors.none },
      FloatBorder = { fg = colors.surface2, bg = colors.none },
      FloatTitle = { fg = colors.sky, bg = colors.none },
      TelescopeBorder = {
        fg = colors.surface2,
        bg = colors.none,
      },
      TelescopeMatching = { fg = colors.yellow },
      TelescopeNormal = {
        bg = colors.none,
      },
      TelescopePromptBorder = {
        fg = colors.surface2,
        bg = colors.none,
      },
      TelescopePromptNormal = {
        fg = colors.text,
        bg = colors.none,
      },
      TelescopePromptPrefix = {
        fg = colors.sky,
        bg = colors.none,
      },
      TelescopePreviewTitle = {
        fg = colors.green,
        bg = colors.none,
      },
      TelescopePreviewNormal = {
        bg = colors.none,
      },
      TelescopePreviewBorder = {
        fg = colors.surface2,
        bg = colors.none,
      },
      TelescopePromptTitle = {
        fg = colors.sky,
        bg = colors.none,
      },
      TelescopeResultsTitle = {
        fg = colors.mantle,
        bg = colors.lavender,
      },
      TelescopeSelection = {
        fg = colors.text,
        bg = colors.surface0,
        style = { 'bold' },
      },
      TelescopeSelectionCaret = { fg = colors.sky, style = { 'bold' } },

      CursorLine = { bg = colors.surface0 },
      CursorLineBG = { bg = colors.surface0 },

      CmpItemMenu = { fg = colors.overlay2, style = { 'italic' } },
      CmpItemAbbrDeprecated = { style = { 'strikethrough' } },
      -- cmp item kind
      CmpItemKindSnippet = { fg = colors.mauve },
      CmpItemKindKeyword = { fg = colors.red },
      CmpItemKindText = { fg = colors.teal },
      CmpItemKindMethod = { fg = colors.blue },
      CmpItemKindConstructor = { fg = colors.blue },
      CmpItemKindFunction = { fg = colors.blue },
      CmpItemKindFolder = { fg = colors.blue },
      CmpItemKindModule = { fg = colors.blue },
      CmpItemKindConstant = { fg = colors.peach },
      CmpItemKindField = { fg = colors.green },
      CmpItemKindProperty = { fg = colors.green },
      CmpItemKindEnum = { fg = colors.green },
      CmpItemKindUnit = { fg = colors.green },
      CmpItemKindClass = { fg = colors.yellow },
      CmpItemKindVariable = { fg = colors.flamingo },
      CmpItemKindFile = { fg = colors.blue },
      CmpItemKindInterface = { fg = colors.yellow },
      CmpItemKindColor = { fg = colors.red },
      CmpItemKindReference = { fg = colors.red },
      CmpItemKindEnumMember = { fg = colors.red },
      CmpItemKindStruct = { fg = colors.blue },
      CmpItemKindValue = { fg = colors.peach },
      CmpItemKindEvent = { fg = colors.blue },
      CmpItemKindOperator = { fg = colors.blue },
      CmpItemKindTypeParameter = { fg = colors.blue },
      CmpItemKindCopilot = { fg = colors.teal },

      -- blink cmp
      BlinkCmpMenuBorder = { fg = colors.surface1, bg = colors.none },
      BlinkCmpMenuSelection = { bg = colors.surface0 },
      BlinkCmpLabelDeprecated = { style = { 'strikethrough' } },
      BlinkCmpKindSnippet = { fg = colors.mauve },
      BlinkCmpKindKeyword = { fg = colors.red },
      BlinkCmpKindText = { fg = colors.teal },
      BlinkCmpKindMethod = { fg = colors.blue },
      BlinkCmpKindConstructor = { fg = colors.blue },
      BlinkCmpKindFunction = { fg = colors.blue },
      BlinkCmpKindFolder = { fg = colors.blue },
      BlinkCmpKindModule = { fg = colors.blue },
      BlinkCmpKindConstant = { fg = colors.peach },
      BlinkCmpKindField = { fg = colors.green },
      BlinkCmpKindProperty = { fg = colors.green },
      BlinkCmpKindEnum = { fg = colors.green },
      BlinkCmpKindUnit = { fg = colors.green },
      BlinkCmpKindClass = { fg = colors.yellow },
      BlinkCmpKindVariable = { fg = colors.flamingo },
      BlinkCmpKindFile = { fg = colors.blue },
      BlinkCmpKindInterface = { fg = colors.yellow },
      BlinkCmpKindColor = { fg = colors.red },
      BlinkCmpKindReference = { fg = colors.red },
      BlinkCmpKindEnumMember = { fg = colors.red },
      BlinkCmpKindStruct = { fg = colors.blue },
      BlinkCmpKindValue = { fg = colors.peach },
      BlinkCmpKindEvent = { fg = colors.blue },
      BlinkCmpKindOperator = { fg = colors.blue },
      BlinkCmpKindTypeParameter = { fg = colors.blue },
      BlinkCmpKindCopilot = { fg = colors.teal },

      -- snacks
      SnacksIndent = { fg = colors.surface2 },
      SnacksIndentScope = { fg = colors.overlay1 },
      SnacksDashboardHeader = { fg = colors.peach },
      SnacksDashboardIcon = { fg = colors.peach },
      SnacksDashboardTitle = { fg = colors.sky },
      SnacksDashboardDesc = { fg = colors.sky },
    }
  end
  require('catppuccin').setup {
    transparent_background = true,
    color_overrides = {
      all = color_overrides,
    },
    custom_highlights = function(colors)
      return custom_highlights(colors)
    end,
    integrations = {
      cmp = true,
      fidget = true,
      telescope = {
        enabled = true,
      },
      native_lsp = {
        enabled = true,
      },
      notify = true,
      treesitter = true,
      snacks = true,
    },
    term_colors = true,
  }
  vim.o.termguicolors = true
  local ok, _ = pcall(vim.cmd.colorscheme, 'catppuccin-mocha')
  if not ok then
    vim.cmd 'colorscheme default'
  end
end

return M
