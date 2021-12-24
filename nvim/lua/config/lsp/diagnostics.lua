local u = require("util")

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
    format = function(d)
      local t = vim.deepcopy(d)
      if d.code then
        t.message = string.format("%s [%s]", t.message, t.code):gsub("1. ", "")
      end
      return t.message
    end,
  },
})

-- signs
local signs = {
  Error = " ",
  Warn = " ",
  Hint = " ",
  Info = " ",
}
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- project-wide diagnostics
require("trouble").setup({
  auto_close = true,
})
u.map("n", "<leader>d", ":Trouble<cr>", { silent = true })
