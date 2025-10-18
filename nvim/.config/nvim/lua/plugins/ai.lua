return {
  {
    'NickvanDyke/opencode.nvim',
    lazy = true,
    event = 'VeryLazy',
    opts = {},
    config = function()
      vim.o.autoread = true

      local oc = require 'opencode'
      -- Keymaps
      vim.keymap.set({ 'n', 'x' }, '<leader>oa', function()
        oc.ask('@this: ', { submit = true })
      end, { desc = 'Ask about this' })
      vim.keymap.set({ 'n', 'x' }, '<leader>os', function()
        oc.select()
      end, { desc = 'Select prompt' })
      vim.keymap.set({ 'n', 'x' }, '<leader>o+', function()
        oc.prompt '@this'
      end, { desc = 'Add this' })
      vim.keymap.set('n', '<leader>ot', function()
        oc.toggle()
      end, { desc = 'Toggle embedded' })
      vim.keymap.set('n', '<leader>oc', function()
        oc.command()
      end, { desc = 'Select command' })
      vim.keymap.set('n', '<leader>on', function()
        oc.command 'session_new'
      end, { desc = 'New session' })
      vim.keymap.set('n', '<leader>oi', function()
        oc.command 'session_interrupt'
      end, { desc = 'Interrupt session' })
      vim.keymap.set('n', '<leader>oA', function()
        oc.command 'agent_cycle'
      end, { desc = 'Cycle selected agent' })
      vim.keymap.set('n', '<S-C-u>', function()
        oc.command 'messages_half_page_up'
      end, { desc = 'Messages half page up' })
      vim.keymap.set('n', '<S-C-d>', function()
        oc.command 'messages_half_page_down'
      end, { desc = 'Messages half page down' })
    end,
  },
}
