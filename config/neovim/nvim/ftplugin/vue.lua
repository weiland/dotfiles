require('lspconfig').volar.setup({
  capabilities = require('lsp').capabilities(),
  on_attach = require('lsp').on_attach,
  filetypes = { 'vue' }
})
