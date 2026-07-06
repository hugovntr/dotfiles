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
        'marksman',
        -- Tools
        'stylua',
        'biome',
        'eslint',
      },
    },
    event = 'VeryLazy',
    dependencies = {
      'mason-org/mason.nvim',
    },
    config = function()
      require 'plugins.config.lsp'
    end,
  },
  {
    'jhofscheier/ltex-utils.nvim', -- LaTeX LSP method implementations
    opts = {
      dictionary = {
        path = vim.api.nvim_call_function('stdpath', { 'cache' }) .. '/ltex/',
        filename = function(lang)
          return lang .. '.txt'
        end,
        use_vim_dict = false,
        vim_cmd_output = false,
      },
      backend = 'ltex_plus',
    },
  },
}
