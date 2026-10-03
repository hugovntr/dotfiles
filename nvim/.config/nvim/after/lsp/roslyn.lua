return {
  filetypes = { 'cs' },
  exe = vim.fs.joinpath(vim.fn.stdpath 'data', 'mason', 'bin', 'roslyn'),
  cmd_env = { DOTNET_ROOT = '/opt/homebrew/opt/dotnet/libexec' },
}
