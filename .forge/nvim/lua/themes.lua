return {
  {
    'zaldih/themery.nvim',
    opts = {
      themes = { 'catppuccin-mocha', 'catppuccin-latte' },
      themeConfigFile = '~/.config/nvim/lua/custom/themes.lua',
      livePreview = true,
    },
    config = function(_, opts)
      require('themery').setup(opts)
      -- Themery block
      -- This block will be replaced by Themery.
      vim.o.termguicolors = true
      vim.cmd 'colorscheme catppuccin-mocha'
      vim.g.theme_id = 4
      -- end themery block
      vim.keymap.set('n', '<leader>ts', '<cmd>Themery<cr>', { noremap = true, desc = '[T]heme [S]witcher' })
    end,
  },
  {
    'catppuccin/nvim',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        transparent_background = true,
        integrations = {
          cmp = true,
          fidget = true,
          telescope = {
            enabled = true,
            style = 'nvchad',
          },
          native_lsp = {
            enabled = true,
          },
          neotree = true,
          notify = true,
          treesitter = true,
        },
        term_colors = true,
      }
    end,
  },
  {
    'xiyaowong/transparent.nvim',
    config = function()
      require('transparent').setup {
        enabled = false,
      }
    end,
  },
}
