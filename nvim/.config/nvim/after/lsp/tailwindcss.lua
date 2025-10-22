return {
  filetypes = { 'javascriptreact', 'typescriptreact', 'html', 'css', 'postcss', 'scss', 'less', 'mdx' },
  settings = {
    tailwindCSS = {
      validate = true,
      lint = {
        cssConflict = 'warning',
        invalidApply = 'error',
        invalidScreen = 'error',
        invalidVariant = 'error',
        invalidConfigPath = 'error',
        invalidTailwindDirective = 'error',
        recommendedVariantOrder = 'warning',
      },
      emmetCompletions = false,
      colorDecorators = false,
      hovers = false,
      classFunctions = { 'tw', 'clsx', 'cn' },
      classAttributes = {
        'class',
        'className',
        'class:list',
        'classList',
        'ngClass',
      },
    },
  },
}
