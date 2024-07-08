require('llm').setup {
  api_token = nil,
  model = 'customqwen', -- CodeQwen but with the following template: {{ .Prompt }}{{ .Response }}
  backend = 'ollama',
  url = 'http://localhost:11434/api/generate',
  request_body = {
    options = {
      temperature = 0.2,
      top_p = 0.95,
      num_ctx = 2048,
      num_predict = 10,
    },
  },
  enable_suggestions_on_files = '*',
  enable_suggestions_on_startup = false,
  disable_url_path_completion = true,
  fim = {
    enabled = true,
    middle = '<fim_middle>',
    prefix = '<fim_prefix>',
    suffix = '<fim_suffix>',
  },
  tls_skip_verify_insecure = true,
  context_window = 512,
  accept_keymap = '<Tab>',
  dismiss_keymap = '<S-Tab>',
  lsp = {
    bin_path = vim.api.nvim_call_function('stdpath', { 'data' }) .. '/mason/bin/llm-ls',
  },
}
