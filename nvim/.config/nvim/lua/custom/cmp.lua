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
    { name = 'path' },
    { name = 'buffer' },
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  formatting = {
    fields = { 'abbr', 'kind', 'menu' },
    expandable_indicator = false,
    format = function(entry, vim_item)
      local kind = require('lspkind').cmp_format { mode = 'symbol_text', maxwidth = 50 }(entry, vim_item)
      local strings = vim.split(kind.kind, '%s', { trimempty = true })
      kind.kind = ' ' .. (strings[1] or '') .. ' '
      kind.menu = ' ' .. (strings[2] or '') .. ''

      return kind
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  experimental = { ghost_text = true },
  completion = { completeopt = 'menu,menuone,noinsert' },

  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),

    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),

    ['<Tab>'] = cmp.mapping.confirm { select = true },
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
