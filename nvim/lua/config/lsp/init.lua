require("config.lsp.diagnostics")
require("config.lsp.kind").setup()

local servers = {
  cssls = {},
  html = {},
  jsonls = {},
  sumneko_lua = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim", "hs" },
          disable = { "lowercase-global" },
        },
      },
    },
  },
  tsserver = {},
  gopls = {},
}

local function on_attach(client, buf)
  require("lsp_signature").on_attach({
    bind = true,
    hint_prefix = " ",
  })
  require("config.lsp.commands").setup(client, buf)
  require("config.lsp.formatting").setup(client, buf)
  require("config.lsp.keys").setup(client, buf)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits" },
}
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local options = {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

require("config.lsp.nls").setup(options)
require("config.lsp.install").setup(servers, options)

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

require("config.lsp.completion")
