return {
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    build = 'make',
    version = false,
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      provider = 'lmstudio',
      providers = {
        lmstudio = {
          __inherited_from = 'openai',
          api_key_name = '',
          endpoint = 'http://localhost:1234/v1',
          model = 'qwen3-4b-mlx',
          disable_tools = false,
          extra_request_body = {
            stream = true,
          },
        },
      },
      selector = {
        provider = 'fzf',
        provider_opts = {},
      },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
    },
  },
}
