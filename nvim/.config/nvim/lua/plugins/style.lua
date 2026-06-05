return {
  -- Unified Theme Manager
  {
    'unified',
    name = 'unified',
    dev = true,
    lazy = false,
    priority = 1000,
    config = function()
      require('custom.unified').setup()
    end,
  },
  -- Automatically select light/dark theme
  {
    'autotheme',
    name = 'autotheme',
    dev = true,
    lazy = false,
    enabled = false, -- Disabled in favor of unified
    priority = 1000,
    dependencies = {
      {
        'themes',
        name = 'themes',
        dev = true,
        lazy = true,
        dependencies = {
          {
            'adibhanna/forest-night.nvim',
            lazy = true,
          },
          { 'uhs-robert/oasis.nvim', lazy = true },
        },
      },
    },
    config = function()
      require('custom.autotheme').setup()
    end,
  },
  {
    'rktjmp/lush.nvim',
    event = 'VeryLazy',
    lazy = true,
  },

  -- Top line (buffers) + Bottom line (slimline)
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    lazy = true,
    dependencies = {
      { 'nvim-mini/mini.icons', opts = {}, lazy = true },
      { 'sschleemilch/slimline.nvim', event = 'VeryLazy' },
    },
    config = function()
      require('mini.icons').setup()
      require('mini.icons').mock_nvim_web_devicons()
      require 'plugins.config.uiline'
    end,
  },

  -- Top + Bottom line
  -- {
  --   'nvim-lualine/lualine.nvim',
  --   event = 'VeryLazy',
  --   lazy = true,
  --   enabled = false,
  --   dependencies = {
  --     { 'nvim-mini/mini.icons', opts = {}, lazy = true },
  --     { 'folke/noice.nvim', lazy = true },
  --     { 'sschleemilch/slimline.nvim', event = 'VeryLazy' },
  --   },
  --   config = function()
  --     require('mini.icons').setup()
  --     require('mini.icons').mock_nvim_web_devicons()
  --     require 'plugins.config.lualine'
  --   end,
  -- },

  -- Color preview
  {
    'uga-rosa/ccc.nvim',
    event = 'VeryLazy',
    lazy = true,
    config = function()
      local ccc = require 'ccc'
      local opts = {
        highlighter = { auto_enable = true },
        highlight_mode = 'background',
        alpha_show = 'show',
        virtual_pos = 'eol',
      }
      ccc.setup(opts)
    end,
  },

  -- Cursor line following the current mode
  {
    'mvllow/modes.nvim',
    event = 'BufEnter',
    lazy = true,
    config = function()
      local opts = {
        line_opacity = 0.25,
        set_cursor = true,
        set_cursorline = true,
        set_number = true,
        set_signcolumn = false,
      }

      -- We defer the initial setup to ensure colorscheme is ready
      vim.schedule(function()
        require('modes').setup(opts)
        vim.o.cmdheight = 0
      end)

      -- Reload when background OR colorscheme changes
      vim.api.nvim_create_autocmd({ 'OptionSet' }, {
        pattern = { 'background' },
        callback = function()
          -- Defer re-setup to ensure highlight groups are fully registered
          vim.schedule(function()
            require('modes').setup(opts)
          end)
        end,
      })
    end,
  },
}
