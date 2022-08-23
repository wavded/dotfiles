local M = {}

function M.setup(_, _)
  vim.cmd("command! LspDefinition lua vim.lsp.buf.definition()")
  vim.cmd("command! LspCodeActions FzfLua lsp_code_actions")
  vim.cmd("command! LspReferences FzfLua lsp_references")
  vim.cmd("command! LspSymbols FzfLua lsp_document_symbols")
  vim.cmd("command! LspImplementations FzfLua lsp_implementations")
  vim.cmd("command! LspDiagList FzfLua diagnostics_workspace")
  vim.cmd(
    "command! LspDiagPrev lua vim.diagnostic.goto_prev({popup_opts = {focusable = false}})"
  )
  vim.cmd(
    "command! LspDiagNext lua vim.diagnostic.goto_next({popup_opts = {focusable = false}})"
  )
  vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
  vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
  vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting_sync()")
  vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")

  vim.cmd("augroup LspAutocommands")

  vim.cmd(
    [[autocmd CursorHold * lua vim.diagnostic.open_float({focusable = false, scope = "c"})]]
  )

  vim.cmd("augroup END")
end

return M
