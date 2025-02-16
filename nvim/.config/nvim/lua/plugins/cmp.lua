return { -- Autocompletion
  { -- Nvim CMP
    'hrsh7th/nvim-cmp',
    event = 'BufEnter',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        build = 'make install_jsregexp',
        dependencies = { 'rafamadriz/friendly-snippets' },
      },
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'onsails/lspkind.nvim',
      'nvim-tree/nvim-web-devicons',
      { 'xzbdmw/colorful-menu.nvim', opts = {} },
    },
    config = function()
      require 'custom.cmp'
    end,
  },
  { -- Blink
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets', 'onsails/lspkind.nvim', 'nvim-tree/nvim-web-devicons', { 'xzbdmw/colorful-menu.nvim', opts = {} } },
    version = '*',
    event = 'BufEnter',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      enabled = function()
        return false
      end,
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      keymap = {
        ['<C-n>'] = { 'select_next' },
        ['<C-p'] = { 'select_prev' },
        ['<Tab>'] = { 'select_and_accept', 'fallback' },
      },

      appearance = {
        nerd_font_variant = 'mono',
      },

      signature = { enabled = false },

      completion = {
        ghost_text = { enabled = false },

        menu = {
          min_width = 40,
          scrollbar = false,
          draw = {
            padding = 1,
            align_to = 'none',
            treesitter = { 'lsp' },
            columns = {
              { 'kind_icon' },
              { 'label', 'label_description', gap = 1 },
            },

            components = {
              kind_icon = {
                ellipsis = false,
                text = function(ctx)
                  local icon = ctx.kind_icon
                  if vim.tbl_contains({ 'Path' }, ctx.source_name) then
                    local dev_icon, _ = require('nvim-web-devicons').get_icon(ctx.label)
                    if dev_icon then
                      icon = dev_icon
                    end
                  else
                    icon = require('lspkind').symbolic(ctx.kind, { mode = 'symbol', maxwidth = 50, ellipsis_char = '...' })
                  end

                  return icon .. ctx.icon_gap
                end,

                highlight = function(ctx)
                  local hl = 'BlinkCmpKind' .. ctx.kind or require('blink.cmp.completion.windows.render.tailwind').get_hl(ctx)
                  if vim.tbl_contains({ 'Path' }, ctx.source_name) then
                    local dev_icon, dev_hl = require('nvim-web-devicons').get_icon(ctx.label)
                    if dev_icon then
                      hl = dev_hl
                    end
                  end
                  return hl
                end,
              },

              label = {
                width = { fill = true, max = 60 },
                text = function(ctx)
                  local highlights_info = require('colorful-menu').blink_highlights(ctx)
                  if highlights_info ~= nil then
                    -- Or you want to add more item to label
                    return highlights_info.label
                  else
                    return ctx.label
                  end
                end,
                highlight = function(ctx)
                  local highlights = {}
                  local highlights_info = require('colorful-menu').blink_highlights(ctx)
                  if highlights_info ~= nil then
                    highlights = highlights_info.highlights
                  end
                  for _, idx in ipairs(ctx.label_matched_indices) do
                    table.insert(highlights, { idx, idx + 1, group = 'BlinkCmpLabelMatch' })
                  end
                  -- Do something else
                  return highlights
                end,
              },
            },
          },
        },
      },
    },
  },
}
