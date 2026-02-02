local M = {
  state = '', -- dark or light
}

function M.apply_palette(theme_data)
  local c = theme_data.colors

  vim.o.termguicolors = true
  vim.g.colors_name = 'unified' .. M.state -- Set the color scheme name

  -- Terminal Colors
  vim.g.terminal_color_0 = c.black
  vim.g.terminal_color_1 = c.red
  vim.g.terminal_color_2 = c.green
  vim.g.terminal_color_3 = c.yellow
  vim.g.terminal_color_4 = c.blue
  vim.g.terminal_color_5 = c.magenta
  vim.g.terminal_color_6 = c.cyan
  vim.g.terminal_color_7 = c.white
  vim.g.terminal_color_8 = c.bright_black
  vim.g.terminal_color_9 = c.bright_red
  vim.g.terminal_color_10 = c.bright_green
  vim.g.terminal_color_11 = c.bright_yellow
  vim.g.terminal_color_12 = c.bright_blue
  vim.g.terminal_color_13 = c.bright_magenta
  vim.g.terminal_color_14 = c.bright_cyan
  vim.g.terminal_color_15 = c.bright_white

  local hl = vim.api.nvim_set_hl

  -- Base Highlights
  hl(0, 'Normal', { fg = c.fg, bg = c.bg })
  hl(0, 'Cursor', { fg = c.bg, bg = c.cursor })
  hl(0, 'Visual', { bg = c.sel_bg, fg = c.sel_fg })
  hl(0, 'LineNr', { fg = c.bright_black })
  hl(0, 'CursorLine', { bg = c.black })
  hl(0, 'CursorLineNr', { fg = c.yellow, bold = true })

  -- Common Groups
  hl(0, 'Comment', { fg = c.bright_black, italic = true })
  hl(0, 'Constant', { fg = c.magenta })
  hl(0, 'String', { fg = c.green })
  hl(0, 'Character', { fg = c.green })
  hl(0, 'Number', { fg = c.magenta })
  hl(0, 'Boolean', { fg = c.magenta })
  hl(0, 'Float', { fg = c.magenta })

  hl(0, 'Identifier', { fg = c.red })
  hl(0, 'Function', { fg = c.blue })

  hl(0, 'Statement', { fg = c.yellow })
  hl(0, 'Conditional', { fg = c.yellow })
  hl(0, 'Repeat', { fg = c.yellow })
  hl(0, 'Label', { fg = c.yellow })
  hl(0, 'Operator', { fg = c.cyan })
  hl(0, 'Keyword', { fg = c.red })
  hl(0, 'Exception', { fg = c.red })

  hl(0, 'PreProc', { fg = c.cyan })
  hl(0, 'Include', { fg = c.blue })
  hl(0, 'Define', { fg = c.cyan })
  hl(0, 'Macro', { fg = c.cyan })
  hl(0, 'PreCondit', { fg = c.cyan })

  hl(0, 'Type', { fg = c.yellow })
  hl(0, 'StorageClass', { fg = c.yellow })
  hl(0, 'Structure', { fg = c.yellow })
  hl(0, 'Typedef', { fg = c.yellow })

  hl(0, 'Special', { fg = c.blue })
  hl(0, 'SpecialChar', { fg = c.blue })
  hl(0, 'Tag', { fg = c.yellow })
  hl(0, 'Delimiter', { fg = c.fg })
  hl(0, 'SpecialComment', { fg = c.bright_black })
  hl(0, 'Debug', { fg = c.red })

  hl(0, 'Underlined', { underline = true })
  hl(0, 'Ignore', { fg = c.bright_black })
  hl(0, 'Error', { fg = c.red, bold = true })
  hl(0, 'Todo', { fg = c.yellow, bold = true })

  -- Pmenu
  hl(0, 'Pmenu', { fg = c.fg, bg = c.black })
  hl(0, 'PmenuSel', { fg = c.bg, bg = c.blue })

  -- Git
  hl(0, 'DiffAdd', { fg = c.green })
  hl(0, 'DiffChange', { fg = c.yellow })
  hl(0, 'DiffDelete', { fg = c.red })

  -- Custom Overrides
  if theme_data.highlights then
    for group, opts in pairs(theme_data.highlights) do
      hl(0, group, opts)
    end
  end

  -- Trigger ColorScheme event so other plugins (lualine, bufferline, etc.) update
  vim.api.nvim_exec_autocmds('ColorScheme', { modeline = false })
end

function M.setup()
  local ok, generated = pcall(require, 'custom.unified.generated')
  if not ok then
    vim.notify("Unified theme not generated. Run 'bun run set-theme <name>'", vim.log.levels.WARN)
    return
  end

  M.generated = generated

  -- Initial clear
  vim.cmd 'hi clear'
  if vim.fn.exists 'syntax_on' then
    vim.cmd 'syntax reset'
  end

  if generated.mode == 'auto' then
    M.enable_auto_detection()
  else
    vim.o.background = generated.mode
    M.apply_palette(generated[generated.mode])
  end
end

function M.enable_auto_detection()
  -- Helper to apply theme based on mode
  local function set_mode(mode)
    local target = (mode == 'dark') and 'dark' or 'light'

    -- Only re-apply if it actually changed, OR if it's the first load
    -- But since we need to ensure plugins catch up, applying it is safer.
    -- We set vim.o.background FIRST so plugins that query it get the right answer.
    if vim.o.background ~= target then
      vim.o.background = target
    end
    M.state = target
    -- Initial clear
    vim.cmd 'hi clear'
    if vim.fn.exists 'syntax_on' then
      vim.cmd 'syntax reset'
    end
    M.apply_palette(M.generated[target])
  end

  -- Use dark-notify if available (macOS)
  local stdout = vim.uv.new_pipe(false)
  ---@diagnostic disable-next-line: missing-fields
  local handle, pid = vim.uv.spawn('dark-notify', {
    stdio = { nil, stdout, nil },
  }, function() end)

  if handle then
    ---@diagnostic disable-next-line: param-type-mismatch
    vim.uv.read_start(stdout, function(_, chunk)
      if chunk then
        vim.schedule(function()
          set_mode(chunk:gsub('%s+', ''))
        end)
      end
    end)

    -- Cleanup
    vim.api.nvim_create_autocmd('QuitPre', {
      callback = function()
        vim.uv.kill(pid, 9)
      end,
    })
  else
    -- Fallback: Use current setting
    set_mode(vim.o.background)
  end

  -- Also watch for manual toggles of 'background' to re-apply palette
  vim.api.nvim_create_autocmd('OptionSet', {
    pattern = 'background',
    callback = function()
      -- If the user manually toggles background in neovim, we re-apply the correct palette
      -- We don't need to set vim.o.background here because the user just did it.
      set_mode(vim.o.background)
    end,
  })
end

return M
