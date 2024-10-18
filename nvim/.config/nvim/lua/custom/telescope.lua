local telescope = require 'telescope'
local actions = require 'telescope.actions'
local themes = require 'telescope.themes'

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(require('telescope.config').values.vimgrep_arguments) }

-- Add search flags
table.insert(vimgrep_arguments, '--hidden')
table.insert(vimgrep_arguments, '--glob')
table.insert(vimgrep_arguments, '!**.git/*')

telescope.setup {
  defaults = vim.tbl_extend('force', themes.get_ivy(), {
    vimgrep_arguments = vimgrep_arguments,
    mappings = {
      i = {
        ['<esc>'] = actions.close,
      },
    },
  }),
  pickers = {
    find_files = {
      find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' },
    },
    colorscheme = {
      enable_preview = true,
    },
  },
  extensions = {
    ['ui-select'] = {
      themes.get_ivy(),
    },
  },
}

-- Enable Telescope extensions if they are installed
pcall(telescope.load_extension, 'fzf')
pcall(telescope.load_extension, 'ui-select')

-- See `:help telescope.builtin`
local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
-- vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
-- vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>sr', builtin.oldfiles, { desc = '[S]earch [R]ecent Files' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>ws', builtin.lsp_workspace_symbols, { desc = '[W]orkspace [S]ymbols' })

-- Match Intellij IDE
vim.keymap.set('n', '<M-p>', builtin.find_files)

-- Slightly advanced example of overriding default behavior and theme
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to Telescope to change the theme, layout, etc.
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

-- It's also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
vim.keymap.set('n', '<leader>s/', function()
  builtin.live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end, { desc = '[S]earch [/] in Open Files' })

-- Shortcut for searching your Neovim configuration files
vim.keymap.set('n', '<leader>sn', function()
  builtin.find_files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[S]earch [N]eovim files' })

-- Shortcut for searching dotfiles
vim.keymap.set('n', '<leader>sd', function()
  local nvim_conf = vim.fn.stdpath 'config'
  local resolve_dotfiles_path = io.popen('readlink -f ' .. nvim_conf, 'r'):read 'a+'
  local dotfiles = resolve_dotfiles_path:match('(.*/nvim).*/nvim'):match '(.*)/nvim'
  builtin.find_files { cwd = dotfiles }
end, { desc = '[S]earch [D]otfiles' })
