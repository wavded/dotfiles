local M = {}

function M.setup(options)
  local nls = require("null-ls")

  nls.config({
    debounce = 150,
    save_after_format = false,

    sources = {
      nls.builtins.code_actions.gitsigns,
      nls.builtins.formatting.stylua,
      nls.builtins.formatting.prettierd,
      nls.builtins.formatting.rustfmt,
      nls.builtins.formatting.goimports,
      nls.builtins.formatting.gofumpt,
      nls.builtins.diagnostics.write_good,
    },
  })
  require("lspconfig")["null-ls"].setup(options)
end

function M.has_formatter(ft)
  local config = require("null-ls.config").get()
  local formatters = config._generators["NULL_LS_FORMATTING"]
  for _, f in ipairs(formatters) do
    if vim.tbl_contains(f.filetypes, ft) then
      return true
    end
  end
end

return M
