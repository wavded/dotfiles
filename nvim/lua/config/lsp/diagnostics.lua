local u = require("util")

-- config
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    virtual_text = false,
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
  }
)

-- signs
local signs = {
  Error = " ",
  Warning = " ",
  Hint = " ",
  Information = " ",
}
for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- project-wide diagnostics
require("trouble").setup()
u.map("n", "<leader>d", ":Trouble<cr>", { silent = true })
