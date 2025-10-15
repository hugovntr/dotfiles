local cmp = require 'cmp'
local luasnip = require 'luasnip'
local lspkind = require 'lspkind'
lspkind.init {}
luasnip.config.set_config {
  history = false,
  updateevents = 'TextChanged,TextChangedI',
}
require('luasnip.loaders.from_vscode').lazy_load()

vim.keymap.set({ 'i', 'n', 's' }, '<C-y>', function()
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  end
end, { silent = true })
vim.keymap.set({ 'i', 's' }, '<C-u>', function()
  if luasnip.locally_jumpable(-1) then
    luasnip.jump(-1)
  end
end, { silent = true })

-- luasnip.config.setup {}
cmp.setup {
  enabled = function()
    local buftype = vim.api.nvim_get_option_value('buftype', { buf = 0 })
    local filetype = vim.bo.filetype
    if buftype == 'prompt' or filetype == 'oil' then
      return false
    end
    return true
  end,
  sources = {
    {
      name = 'nvim_lsp',
      entry_filter = function(entry)
        -- Ugliest fix for auto-import of "lucide-react" icons and "@radix-ui/" components
        local label = entry:get_completion_item().label
        local detail = entry:get_completion_item().detail or ''
        if label:match 'lucide%-react' or detail:match 'lucide%-react' or label:match '@radix%-ui/*' or detail:match '@radix%-ui/*' then
          return false
        end
        return true
      end,
    },
    { name = 'luasnip' },
    { name = 'emmet' },
    {
      name = 'async_path',
      option = {
        show_hidden_files_by_default = true,
      },
    },
    -- { name = 'buffer' },
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  formatting = {
    fields = { 'kind', 'abbr', 'menu' },
    expandable_indicator = false,
    format = function(entry, vim_item)
      local highlight_info = require('colorful-menu').cmp_highlights(entry)
      if highlight_info ~= nil then
        vim_item.abbr_hl_group = highlight_info.highlights
        vim_item.abbr = highlight_info.text
      end

      local kind = lspkind.cmp_format { mode = 'symbol_text' }(entry, vim.deepcopy(vim_item))

      -- local item = lspkind.cmp_format { mode = 'symbol', maxwidth = 50, ellipsis_char = '...' }(entry, vim_item)
      local strings = vim.split(kind.kind, '%s', { trimempty = true })
      vim_item.kind = ' ' .. (strings[1] or '') .. '  '
      vim_item.menu = ''
      -- item.menu = '  (' .. (strings[2] or '') .. ')'

      -- if highlight_info ~= nil then
      --   item.abbr_hl_group = highlight_info.highlights
      --   item.abbr = highlight_info.text
      -- end

      return vim_item
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    completion = {
      border = 'rounded',
      winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:CursorLineBG,Search:None',
      col_offset = -4,
      side_padding = 0,
      scrollbar = false,
    },
    documentation = cmp.config.window.bordered(),
  },
  experimental = { ghost_text = false },
  completion = { completeopt = 'menu,menuone,noinsert' },

  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),

    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),

    -- ['<Tab>'] = cmp.mapping.confirm { select = true },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm()
      else
        fallback()
      end
    end),
    -- ['<Enter>'] = cmp.mapping.confirm { select = true },
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<C-l>'] = cmp.mapping(function()
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { 'i', 's' }),
    ['<C-h>'] = cmp.mapping(function()
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { 'i', 's' }),
  },
}
