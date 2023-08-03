local M = {}

function M.setup(options)
  local nls = require("null-ls")

  local opts = vim.tbl_deep_extend("force", options, {
    sources = {
      nls.builtins.code_actions.gitsigns,
      nls.builtins.formatting.stylua,
      nls.builtins.formatting.prettierd.with({
        extra_filetypes = { "pug" },
      }),
      nls.builtins.formatting.rustfmt,
      -- nls.builtins.formatting.google_java_format,
      nls.builtins.formatting.phpcsfixer,
      nls.builtins.formatting.goimports,
      nls.builtins.formatting.golines.with({
        extra_args = {
          "-m",
          "80",
          "--no-reformat-tags",
          "--base-formatter",
          "gofumpt",
        },
      }),
      nls.builtins.diagnostics.vale.with({
        extra_filetypes = { "text", "gitcommit" },
      }),
    },
  })
  nls.setup(opts)
end

function M.has_formatter(ft)
  local formatters = require("null-ls").get_source({
    method = require("null-ls").methods.FORMATTING,
  })
  for _, f in ipairs(formatters) do
    if f.filetypes[ft] ~= nil then
      return true
    end
  end
end

return M
