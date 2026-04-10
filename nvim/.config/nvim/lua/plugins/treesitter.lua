return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    branch = 'main',
    lazy = false,
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' },
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'html',
        'lua',
        'go',
        'markdown',
        'markdown_inline',
        'vim',
        'vimdoc',
        'python',
        'javascript',
        'typescript',
        'tsx',
        'json',
        'dockerfile',
        'htmldjango',
        'yaml',
        'json',
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- additional_vim_regex_highlighting = false,
      },
      indent = { enable = true, disable = { 'ruby' } },
      textobjects = {
        select = {
          enable = true,

          -- Automatically jumpt forward to textobject
          lookahead = true,

          keymaps = {
            ['a='] = { query = '@assignment.outer', desc = 'Select outer part of assignment' },
            ['i='] = { query = '@assignment.inner', desc = 'Select inner part of assignment' },
            ['j='] = { query = '@assignment.lhs', desc = 'Select left part of assignment' },
            ['m='] = { query = '@assignment.rhs', desc = 'Select right part of assignment' },

            ['aa'] = { query = '@parameter.outer', desc = 'Select outer part of a parameter/argument' },
            ['ia'] = { query = '@parameter.inner', desc = 'Select inner part of a parameter/argument' },

            ['ac'] = { query = '@conditional.outer', desc = 'Select the outer part of a conditional' },
            ['ic'] = { query = '@conditional.inner', desc = 'Select inner part of a conditional' },
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['<leader>na'] = '@parameter.inner', -- swap parameter/argument with next
            ['<leader>nm'] = '@function.outer', -- swap function with next
          },
          swap_previous = {
            ['<leader>pa'] = '@parameter.inner', -- swap parameter/argument with previous
            ['<leader>pm'] = '@function.inner', -- swap function with previous
          },
        },
      },
    },
  },
  {
    'MeanderingProgrammer/markdown.nvim',
    event = 'BufEnter *.md(x)?',
    opts = {
      file_types = { 'markdown', 'mdx', 'Avante' },
    },
    ft = { 'markdown', 'mdx', 'Avante' },
  },
  {
    'davidmh/mdx.nvim',
    config = true,
    event = 'BufEnter *.mdx',
  },
}
