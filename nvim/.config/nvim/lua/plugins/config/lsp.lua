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
    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

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
  end,
})
