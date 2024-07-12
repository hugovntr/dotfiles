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
  enabled = true,
  sources = {
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'emmet' },
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  formatting = {
    fields = { 'kind', 'abbr', 'menu' },
    expandable_indicator = true,
    format = function(entry, vim_item)
      local item = lspkind.cmp_format { mode = 'symbol_text', maxwidth = 50, ellipsis_char = '...' }(entry, vim_item)
      local strings = vim.split(item.kind, '%s', { trimempty = true })
      item.kind = ' ' .. (strings[1] or '') .. '  '
      item.menu = '  (' .. (strings[2] or '') .. ')'

      return item
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
  experimental = { ghost_text = true },
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
    ['<Enter>'] = cmp.mapping.confirm { select = true },
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
