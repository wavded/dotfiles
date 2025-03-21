vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "if_many",
    header = "",
    prefix = "",
    width = 50,
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
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
