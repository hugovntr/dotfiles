return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    opts = {
      ensure_installed = { 'bash', 'c', 'html', 'lua', 'markdown', 'vim', 'vimdoc', 'python', 'javascript', 'typescript', 'tsx', 'json', 'dockerfile' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- additional_vim_regex_highlighting = false,
      },
      indent = { enable = true, disable = { 'ruby' } },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-d>',
          node_incremental = '<C-d>',
          scope_incremental = false,
          node_decremental = '<bs>',
        },
      },
      textobjects = {
        select = {
          enable = true,

          -- Automatically jumpt forward to textobject
          lookahead = true,

          keymaps = {
            ['a='] = { query = '@assignment.outer', desc = 'Select outer part of assignment' },
            ['i='] = { query = '@assignment.inner', desc = 'Select inner part of assignment' },
            ['m='] = { query = '@assignment.lhs', desc = 'Select left part of assignment' },
            ['h='] = { query = '@assignment.rhs', desc = 'Select right part of assignment' },

            ['aa'] = { query = '@parameter.outer', desc = 'Select outer part of a parameter/argument' },
            ['ia'] = { query = '@parameter.inner', desc = 'Select inner part of a parameter/argument' },

            ['ai'] = { query = '@conditional.outer', desc = 'Select the outer part of a conditional' },
            ['ii'] = { query = '@conditional.inner', desc = 'Select inner part of a conditional' },
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
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)

      local r = require 'nvim-treesitter.textobjects.repeatable_move'
      --
      -- vim , and ; repeat last command
      vim.keymap.set({ 'n', 'x', 'o' }, ';', r.repeat_last_move)
      vim.keymap.set({ 'n', 'x', 'o' }, ',', r.repeat_last_move_opposite)

      -- make f, F, t, T also repeatable
      vim.keymap.set({ 'n', 'x', 'o' }, 'f', r.builtin_f)
      vim.keymap.set({ 'n', 'x', 'o' }, 'F', r.builtin_F)
      vim.keymap.set({ 'n', 'x', 'o' }, 't', r.builtin_t)
      vim.keymap.set({ 'n', 'x', 'o' }, 'T', r.builtin_T)

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  },
}
