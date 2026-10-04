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
      {
        'mason-org/mason.nvim',
        opts = {
          registries = {
            'github:mason-org/mason-registry',
            'github:Crashdummyy/mason-registry',
          },
        },
      },
    },
    config = function()
      require 'plugins.config.lsp'
    end,
  },
  {
    'jhofscheier/ltex-utils.nvim', -- LaTeX LSP method implementations
    lazy = true,
    -- Must cover every filetype ltex_plus attaches to (see after/lsp/ltex_plus.lua),
    -- plus tex: the plugin's BufUnload/BufEnter autocmds persist ltex settings for
    -- *.tex and *.md, and setup() applies the opts below.
    ft = { 'tex', 'latex', 'plaintex', 'markdown', 'mdx', 'bib', 'rst', 'text' },
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
