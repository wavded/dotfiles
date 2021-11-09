require("config.lsp.diagnostics")
require("config.lsp.kind").setup()

local servers = {
  cssls = {},
  html = {},
  jsonls = {},
  sumneko_lua = {
    settings = { Lua = { diagnostics = { globals = { "vim" } } } },
  },
  tsserver = {},
  gopls = {
    settings = { gopls = { gofumpt = true } },
  },
}

local function on_attach(client, buf)
  require("lsp.commands").setup(client)
  require("lsp.formatting").setup(client, buf)
  require("lsp.keys").setup(client, buf)
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

require("config.lsp.null-ls").setup(options)
require("config.lsp.install").setup(servers, options)
