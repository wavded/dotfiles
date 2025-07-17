return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "biome",
        "cssls",
        "denols",
        "eslint",
        "golangci_lint_ls",
        "gopls",
        "html",
        "jdtls",
        "jsonls",
        "kotlin_language_server",
        "lua_ls",
        "phpactor",
        "postgres_lsp",
        "rust_analyzer",
        "somesass_ls",
        "vale_ls",
        "vtsls",
      },
      automatic_installation = true,
      automatic_enable = false,
    },
  },
}
