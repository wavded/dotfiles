local M = {}

function M.setup(options)
  local nls = require("null-ls")
  local utils = require("null-ls.utils")

  local opts = vim.tbl_deep_extend("force", options, {
    sources = {
      nls.builtins.code_actions.gitsigns,
      nls.builtins.formatting.stylua,
      nls.builtins.formatting.prettier.with({
        condition = function(u)
          return u.root_has_file({ "deno.json" }) == false
        end,
        extra_filetypes = { "pug" },
      }),
      nls.builtins.formatting.google_java_format,
      nls.builtins.formatting.phpcsfixer,
      nls.builtins.diagnostics.vale.with({
        extra_filetypes = { "text", "gitcommit" },
      }),
      nls.builtins.diagnostics.ktlint,
      nls.builtins.diagnostics.phpstan,
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
