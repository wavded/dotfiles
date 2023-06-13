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
    "rust_analyzer",
    "lua_ls",
    "tsserver",
  },
  automatic_installation = true,
})
