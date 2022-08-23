local M = {}

function M.format()
  vim.lsp.buf.formatting_sync()
end

function M.setup(client, buf)
  local ft = vim.api.nvim_buf_get_option(buf, "filetype")
  local nls = require("lsp.null-ls")

  local enable = false
  if nls.has_formatter(ft) or ft == "go" then
    enable = client.name == "null-ls"
  else
    enable = not (client.name == "null-ls")
  end

  client.resolved_capabilities.document_formatting = enable

  -- format on save
  if client.resolved_capabilities.document_formatting then
    vim.cmd([[
      augroup LspFormat
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua require("lsp.formatting").format()
      augroup END
    ]])
  end
end

return M
