vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('init-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

    map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

    map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

    map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

    map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

    map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
    map('ss', vim.lsp.buf.code_action, 'Code Action (alias <leader>ca)')

    map('K', vim.lsp.buf.hover, 'Hover Documentation')

    -- WARN: This is not Goto Definition, this is Goto Declaration.
    --  For example, in C this would take you to the header.
    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    -- Inlay Hints
    map('<leader>i', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { 0 }, { 0 })
    end, 'Toggle [I]nlay Hints')

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local buf = event.buf

    if client and client.server_capabilities.inlayHintProvider then
      vim.defer_fn(function()
        vim.lsp.inlay_hint.enable(true, { buf })
      end, 20)
    end

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    -- local client = vim.lsp.get_client_by_id(event.data.client_id)
    -- if client and client.server_capabilities.documentHighlightProvider then
    --   vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
    --     buffer = event.buf,
    --     callback = vim.lsp.buf.document_highlight,
    --   })
    --
    --   vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
    --     buffer = event.buf,
    --     callback = vim.lsp.buf.clear_references,
    --   })
    -- end
  end,
})

local servers = {
  clangd = {},
  gopls = {},
  pyright = {
    settings = {
      pyright = {
        disableOrganizeImports = true,
      },
      python = { analysis = { ignore = { '*' } } },
    },
  },
  ruff = {
    init_options = {
      settings = {
        fixAll = true,
        organizeImports = true,
        lint = { enable = true },
        codeAction = {
          disableRuleComment = { enable = true },
          fixViolation = { enable = true },
        },
      },
    },
  },
  cssls = {
    filetypes = { 'css', 'scss', 'less' },
    init_options = { provideFormatter = true },
    root_markers = { 'package.json', '.git' },
    settings = {
      css = { validate = true, lint = { unknownAtRules = 'ignore' } },
      scss = { validate = true, lint = { unknownAtRules = 'ignore' } },
      less = { validate = true, lint = { unknownAtRules = 'ignore' } },
    },
  },
  tailwindcss = {
    filetypes = { 'javascriptreact', 'typescriptreact', 'html', 'css', 'postcss', 'scss', 'less', 'mdx' },
    settings = {
      tailwindCSS = {
        validate = true,
        lint = {
          cssConflict = 'warning',
          invalidApply = 'error',
          invalidScreen = 'error',
          invalidVariant = 'error',
          invalidConfigPath = 'error',
          invalidTailwindDirective = 'error',
          recommendedVariantOrder = 'warning',
        },
        classAttributes = {
          'class',
          'className',
          'class:list',
          'classList',
          'ngClass',
        },
      },
    },
  },
  vtsls = {
    filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
    settings = {
      complete_function_calls = true,
      vtsls = {
        enableMoveToFileCodeAction = true,
        autoUseWorkspaceTsdk = true,
        experimental = {
          maxInlayHintLength = 30,
          completion = {
            enableServerSideFuzzyMatch = false,
          },
        },
      },
      typescript = {
        updateImportsOnFileMove = { enabled = 'always' },
        suggest = {
          completeFunctionCalls = true,
          autoImports = true,
        },
        inlayHints = {
          enumMemberValues = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          parameterNames = { enabled = 'literals' },
          parameterTypes = { enabled = true },
          propertyDeclarationTypes = { enabled = true },
          variableTypes = { enabled = true },
        },
        preferences = {
          preferTypeOnlyAutoImports = true,
        },
      },
    },
  },
  -- ts_ls = {
  --   enabled = false,
  --   settings = {
  --     typescript = {
  --       inlayHints = {
  --         includeInlayEnumMemberValueHints = true,
  --         includeInlayFunctionLikeReturnTypeHints = true,
  --         includeInlayFunctionParameterTypeHints = true,
  --         includeInlayParameterNameHints = 'all', -- 'none' | 'literals' | 'all';
  --         includeInlayParameterNameHintsWhenArgumentMatchesName = false,
  --         includeInlayPropertyDeclarationTypeHints = true,
  --         includeInlayVariableTypeHints = false,
  --       },
  --     },
  --     preferences = {
  --       autoImportFileExcludePatterns = {},
  --     },
  --   },
  -- },
  ltex = {
    filetypes = { 'bib', 'plaintex', 'rst', 'text', 'mdx', 'markdown' },
    settings = {
      ltex = {
        language = 'en-US',
        checkFrequency = 'save',
        additionalRules = {
          enablePickyRules = false,
          motherTongue = 'en-US',
        },
      },
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
        diagnostics = {
          workspaceEvent = 'OnSave',
        },
      },
    },
  },
  emmet_language_server = {
    settings = {
      showSuggestionsAsSnippets = true,
    },
  },
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities()) -- Nvim CMP
capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities(capabilities)) -- Blink

require('mason').setup()
local lspconfig = require 'lspconfig'

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
  'stylua', -- Used to format Lua code
  'prettierd',
  'llm-ls',
  -- 'emmet-language-server',
})
require('mason-tool-installer').setup { ensure_installed = ensure_installed }

for name, server in pairs(servers) do
  server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
  lspconfig[name].setup(server)
end

require('mason-lspconfig').setup {
  ensure_installed = vim.tbl_keys(servers or {}),
  automatic_installation = true,
  automatic_enable = {},
  -- handlers = {
  --   function(server_name)
  --     local server = servers[server_name] or {}
  --     server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
  --     require('lspconfig')[server_name].setup(server)
  --   end,
  -- },
}
