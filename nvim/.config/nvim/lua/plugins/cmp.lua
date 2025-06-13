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
      { 'xzbdmw/colorful-menu.nvim' },
      { 'L3MON4D3/LuaSnip', version = 'v2.*' },
    },
    version = '*',
    event = 'InsertEnter',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {},
    config = function()
      require 'custom.blink'
    end,
  },
}
