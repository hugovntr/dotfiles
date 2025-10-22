return {
  settings = {
    completion = {
      callSnippet = 'Replace',
    },
    diagnostics = {
      workspaceEvent = 'OnSave',
    },
    runtime = { version = 'LuaJIT' },
    workspace = {
      library = vim.api.nvim_get_runtime_file('', true),
    },
  },
}
