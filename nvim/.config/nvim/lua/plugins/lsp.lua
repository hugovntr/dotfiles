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
        'ltex',
        'emmet_language_server',
        'rust_analyzer',
        -- Tools
        'stylua',
        'biome',
        'eslint',
      },
    },
    event = 'VeryLazy',
    dependencies = {
      'mason-org/mason.nvim',
      'neovim/nvim-lspconfig',
    },
    config = function()
      require 'plugins.config.lsp'
    end,
  },
}
