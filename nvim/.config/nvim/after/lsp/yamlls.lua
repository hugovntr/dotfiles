return {
  filetypes = { 'yaml', 'yml' },
  settings = {
    yaml = {
      format = {
        enable = true,
        singleQuote = true,
        printWidth = 120,
      },
      hover = true,
      completion = true,
      validate = true,
      schemaStore = {
        enable = true,
        url = 'https://www.schemastore.org/json',
      },
    },
  },
}
