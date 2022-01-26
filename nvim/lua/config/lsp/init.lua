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
  jdtls = {},
  rls = {
    settings = {
      rust = {
        unstable_feature = true,
        build_on_save = false,
        all_features = true,
        clippy_preference = "on",
      },
    },
  },
  tsserver = {},
  gopls = {},
  golangci_lint_ls = {
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
require("config.lsp.completion")
