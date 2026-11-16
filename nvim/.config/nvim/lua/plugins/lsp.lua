return {
  {
    'mason-org/mason-lspconfig.nvim',
    opts = {
      ensure_installed = {
        -- Language Servers
        'astro',
        'lua_ls',
        'html',
        'cssls',
        'tailwindcss',
        'vtsls',
        'clangd',
        'gopls',
        'ruff',
        'ltex_plus',
        'emmet_language_server',
        'rust_analyzer',
        'yamlls',
        'jsonls',
        'marksman',
        -- Tools
        'stylua',
        'biome',
        'eslint',
      },
    },
    event = 'VeryLazy',
    dependencies = {
      {
        'mason-org/mason.nvim',
        opts = {
          registries = {
            'github:mason-org/mason-registry',
            'github:Crashdummyy/mason-registry',
          },
        },
      },
      {
        'b0o/schemastore.nvim',
        lazy = true,
      },
    },
    config = function()
      require 'plugins.config.lsp'
    end,
  },
  {
    'seblyng/roslyn.nvim',
    lazy = true,
    -- plugin/roslyn.lua is what calls vim.lsp.enable('roslyn'); without a trigger the
    -- plugin never loads and the C# client is never started.
    ft = { 'cs', 'razor', 'cshtml' },
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {
      -- your configuration comes here; leave empty for default settings
      filewatching = 'roslyn',
    },
  },
}
