return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = {
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
        "lua_ls",
        "phpactor",
        "rust_analyzer",
        "somesass_ls",
        "vtsls",
      },
      automatic_installation = true,
    },
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = "User FilePost",
    dependencies = {
      "b0o/schemastore.nvim", -- simple access to json-language-server schemae
      "nvimtools/none-ls.nvim", -- non lsp support
    },
  },
}
