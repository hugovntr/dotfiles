local M = {}

M.llm_nvim = function()
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
        num_predict = 128,
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
    debounce_ms = 150,
    accept_keymap = '<Tab>',
    dismiss_keymap = '<S-Tab>',
    lsp = {
      bin_path = vim.api.nvim_call_function('stdpath', { 'data' }) .. '/mason/bin/llm-ls',
    },
  }
end

return M
-- local completion = require 'llm.completion'
--
-- local function accept_suggestion()
--   if not completion.suggestion or not completion.shown_suggestion then
--     return [[<Tab>]]
--   else
--     vim.schedule(completion.complete)
--   end
-- end
--
-- vim.keymap.set('i', '<Tab>', accept_suggestion, { expr = true, noremap = true })
