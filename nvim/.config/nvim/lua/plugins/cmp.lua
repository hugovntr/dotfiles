return { -- Autocompletion
  -- { -- Nvim CMP
  --   'iguanacucumber/magazine.nvim',
  --   name = 'nvim-cmp',
  --   event = 'BufEnter',
  --   dependencies = {
  --     {
  --       'L3MON4D3/LuaSnip',
  --       build = 'make install_jsregexp',
  --       dependencies = { 'rafamadriz/friendly-snippets' },
  --     },
  --     'saadparwaiz1/cmp_luasnip',
  --     -- 'hrsh7th/cmp-nvim-lsp',
  --     -- 'hrsh7th/cmp-path',
  --     { 'iguanacucumber/mag-nvim-lsp', name = 'cmp-nvim-lsp', opts = {} },
  --     { 'iguanacucumber/mag-nvim-lua', name = 'cmp-nvim-lua' },
  --     { 'iguanacucumber/mag-buffer', name = 'cmp-buffer' },
  --     { 'https://codeberg.org/FelipeLema/cmp-async-path', name = 'cmp-path' },
  --     'onsails/lspkind.nvim',
  --     'nvim-tree/nvim-web-devicons',
  --     { 'xzbdmw/colorful-menu.nvim', opts = {} },
  --   },
  --   config = function()
  --     require 'custom.cmp'
  --   end,
  -- },
  { -- Blink
    'saghen/blink.cmp',
    dependencies = {
      'rafamadriz/friendly-snippets',
      'onsails/lspkind.nvim',
      'nvim-tree/nvim-web-devicons',
      { 'xzbdmw/colorful-menu.nvim' },
      { 'L3MON4D3/LuaSnip', version = 'v2.*' },
    },
    version = '*',
    event = 'InsertEnter',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      enabled = function()
        return true
      end,
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        per_filetype = {
          sql = { 'snippets', 'dadbod', 'buffer' },
        },
        providers = {
          dadbod = { name = 'Dadbod', module = 'vim_dadbod_completion.blink' },
        },
      },
      -- snippets = { preset = 'luasnip' },

      keymap = {
        ['<C-n>'] = { 'select_next' },
        ['<C-p'] = { 'select_prev' },
        ['<Tab>'] = { 'select_and_accept', 'fallback' },
        ['<C-y>'] = { 'snippet_forward' },
        ['<C-u>'] = { 'snippet_backward' },
      },

      appearance = {
        nerd_font_variant = 'mono',
      },

      fuzzy = {
        implementation = 'prefer_rust_with_warning',
        prebuilt_binaries = { download = true },
        sorts = {
          function(a, b)
            if (a.client_name == nil or b.client_name == nil) or (a.client_name == b.client_name) then
              return
            end
            return b.client_name == 'emmet_ls'
          end,
          'score',
          'sort_text',
        },
      },

      signature = {
        enabled = false,
        window = {
          show_documentation = false,
        },
      },

      cmdline = {
        completion = {
          menu = { auto_show = true },
        },
      },

      completion = {
        ghost_text = { enabled = false },

        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
        },

        list = {
          selection = {
            preselect = true,
            auto_insert = false,
          },
        },

        menu = {
          min_width = 40,
          scrollbar = false,
          border = 'single',
          draw = {
            padding = 1,
            gap = 2,
            align_to = 'label',
            treesitter = { 'lsp' },
            columns = {
              { 'kind_icon' },
              { 'label', 'label_description', gap = 2 },
            },

            components = {
              kind_icon = {
                text = function(ctx)
                  local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                  return kind_icon
                end,
                highlight = function(ctx)
                  local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                  return hl
                end,
              },
              kind = {
                highlight = function(ctx)
                  local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                  return hl
                end,
              },
              -- kind_icon = {
              --   ellipsis = false,
              --   text = function(ctx)
              --     local icon = ctx.kind_icon
              --     if vim.tbl_contains({ 'Path' }, ctx.source_name) then
              --       local dev_icon, _ = require('nvim-web-devicons').get_icon(ctx.label)
              --       if dev_icon then
              --         icon = dev_icon
              --       end
              --     else
              --       icon = require('lspkind').symbolic(ctx.kind, { mode = 'symbol' })
              --     end
              --
              --     return icon .. ctx.icon_gap
              --   end,
              --
              --   highlight = function(ctx)
              --     -- local hl = 'BlinkCmpKind' .. ctx.kind or require('blink.cmp.completion.windows.render.tailwind').get_hl(ctx)
              --     local hl = ctx.kind_hl
              --     if vim.tbl_contains({ 'Path' }, ctx.source_name) then
              --       local dev_icon, dev_hl = require('nvim-web-devicons').get_icon(ctx.label)
              --       if dev_icon then
              --         hl = dev_hl
              --       end
              --     end
              --     return hl
              --   end,
              -- },

              label = {
                text = function(ctx)
                  return require('colorful-menu').blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return require('colorful-menu').blink_components_highlight(ctx)
                end,
              },
            },
          },
        },
      },
    },
  },
}
