return {
  filetypes = { 'css', 'scss', 'less' },
  init_options = { provideFormatter = true },
  root_markers = { 'package.json', '.git' },
  settings = {
    css = { validate = true, lint = { unknownAtRules = 'ignore' } },
    scss = { validate = true, lint = { unknownAtRules = 'ignore' } },
    less = { validate = true, lint = { unknownAtRules = 'ignore' } },
  },
}
