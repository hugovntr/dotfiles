return {
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    build = 'make',
    opts = {
      provider = 'openai',
      openai = {
        api_key_name = 'USER',
        endpoint = 'http://127.0.0.1:11434/v1',
        model = 'llama3.2:3b',
        temperature = 0,
        ['local'] = true,
      },
    },
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'MeanderingProgrammer/markdown.nvim',
    },
  },
  {
    'hugovntr/llm.nvim',
    branch = 'fix-keymaps',
    dependencies = {
      'nomnivore/ollama.nvim',
    },
    event = 'VeryLazy',
    config = function()
      require('custom.llm').llm_nvim()
    end,
  },
  {
    'nomnivore/ollama.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'rcarriga/nvim-notify',
    },
    config = function()
      local ollama = require 'ollama'
      local notify = require 'notify'
      ollama.setup {
        model = 'codeqwen',
        serve = {
          on_start = false,
          command = 'ollama',
          args = { 'serve' },
          stop_command = 'pkill',
          stop_args = { '-SIGTERM', 'ollama' },
        },
        -- cmd = { 'Ollama', 'OllamaModel', 'OllamaServe', 'OllamaServeStop' },
      }

      vim.api.nvim_create_autocmd('VimLeavePre', {
        callback = function()
          ollama.stop_serve()
          vim.g.ollama_started = false
        end,
      })

      vim.keymap.set({ 'n', 'v' }, '<leader>ai', function()
        if vim.g.ollama_started == true then
          ollama.stop_serve()
          vim.api.nvim_command 'LLMToggleAutoSuggest'
          notify('Server Stopped', 'info', {
            title = 'Ollama',
          })
          vim.g.ollama_started = false
          return
        end
        ollama.run_serve()
        vim.api.nvim_command 'LLMToggleAutoSuggest'
        notify('Server Started', 'info', {
          title = 'Ollama',
        })
        vim.g.ollama_started = true
      end, { desc = 'Toggle the AI inference' })

      vim.keymap.set({ 'n', 'v' }, '<leader>oo', function()
        ollama.prompt()
      end, { desc = 'Ollama prompt' })

      vim.keymap.set({ 'n', 'v' }, '<leader>og', function()
        ollama.prompt 'Generate_Code'
      end, { desc = 'Ollama Generate Code' })

      vim.keymap.set({ 'n', 'v' }, '<leader>oe', function()
        ollama.prompt 'Explain_Code'
      end, { desc = 'Ollama Explain Code' })

      vim.keymap.set({ 'n', 'v' }, '<leader>os', function()
        ollama.prompt 'Simplify_Code'
      end, { desc = 'Ollama Simplify Code' })
    end,
  },
}
