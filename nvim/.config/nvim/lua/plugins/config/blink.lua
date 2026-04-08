local blink = require 'blink-cmp'

blink.setup {
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
    min_keyword_length = 0,
  },
  -- snippets = { preset = 'luasnip' },

  keymap = {
    ['<C-n>'] = { 'select_next' },
    ['<C-p'] = { 'select_prev' },
    ['<Tab>'] = { 'select_and_accept', 'fallback' },
    ['<C-y>'] = { 'snippet_forward', 'fallback' },
    ['<C-u>'] = { 'snippet_backward', 'fallback' },
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
    keyword = { range = 'full' },

    ghost_text = { enabled = false },

    documentation = {
      auto_show = true,
      auto_show_delay_ms = 500,
      window = { border = 'none' },
    },

    trigger = {
      show_on_keyword = true,
      prefetch_on_insert = false,
      show_on_trigger_character = true,
      show_on_insert_on_trigger_character = true,
      show_on_blocked_trigger_characters = { ' ', '\n', '\t' },
      show_on_x_blocked_trigger_characters = { "'", '"' },
    },

    accept = {
      auto_brackets = { enabled = true },
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
      border = 'none',
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
}
