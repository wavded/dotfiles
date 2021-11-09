local lspconfig = require("lspconfig")
local configs = require("lspconfig/configs")

if not lspconfig.golangcilsp then
  configs.golangcilsp = {
    default_config = {
      cmd = { "golangci-lint-langserver" },
      root_dir = lspconfig.util.root_pattern(".git", "go.mod"),
      init_options = {
        command = {
          "golangci-lint",
          "run",
          "--enable",
          "gosec",
          "--disable",
          "lll",
          "--out-format",
          "json",
        },
      },
    },
  }
end
lspconfig.golangcilsp.setup({
  filetypes = { "go" },
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
})
