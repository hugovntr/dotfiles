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
        -- Tools
        'stylua',
        'biome',
        'eslint',
      },
    },
    event = 'VeryLazy',
    dependencies = {
      'mason-org/mason.nvim',
      'jhofscheier/ltex-utils.nvim', -- LaTeX LSP method implementations
    },
    config = function()
      require 'plugins.config.lsp'
    end,
  },
}
