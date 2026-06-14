return {
  filetypes = { 'bib', 'plaintex', 'rst', 'text', 'mdx', 'markdown' },
  on_attach = function(_, bufnr)
    require('ltex-utils').on_attach(bufnr)
  end,
  settings = {
    ltex = {
      language = 'en-US',
      checkFrequency = 'save',
      additionalRules = {
        enablePickyRules = false,
        motherTongue = 'en-US',
      },
    },
  },
}
