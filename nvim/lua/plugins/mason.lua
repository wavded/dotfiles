require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = {
    "cssls",
    "denols",
    "eslint",
    "golangci_lint_ls",
    "gopls",
    "html",
    "jdtls",
    "jsonls",
    "kotlin_language_server",
    "phpactor",
    "rls",
    "sumneko_lua",
    "tsserver",
  },
  automatic_installation = true,
})
