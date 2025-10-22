return {
  filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
  settings = {
    vtsls = {
      enableMoveToFileCodeAction = true,
      autoUseWorkspaceTsdk = true,
      experimental = {
        maxInlayHintLength = 30,
        completion = {
          entriesLimit = 30,
          enableServerSideFuzzyMatch = true,
        },
      },
    },
    typescript = {
      updateImportsOnFileMove = { enabled = 'always' },
      suggest = {
        completeFunctionCalls = true,
        autoImports = true,
      },
      workspaceSymbols = { scope = 'currentProject' },
      inlayHints = {
        --   enumMemberValues = { enabled = true },
        --   functionLikeReturnTypes = { enabled = true },
        --   parameterNames = { enabled = 'literals' },
        --   parameterTypes = { enabled = true },
        --   propertyDeclarationTypes = { enabled = true },
        variableTypes = { enabled = true },
      },
      preferences = {
        preferTypeOnlyAutoImports = true,
        importModuleSpecifier = 'non-relative',
        autoImportFileExcludePatterns = { 'lucide-react', 'motion/react-m', 'next/dist', 'motion/react' },
      },
      tsserver = {
        useSeparateSyntaxServer = true,
        useSyntaxServer = 'auto',
      },
    },
  },
}
