local M = {}

function M.setup(_, _)
  vim.cmd("command! LspDefinition lua Snacks.picker.lsp_definitions()")
  vim.cmd("command! LspTypeDefinition lua vim.lsp.buf.type_definitions()")
  vim.cmd("command! LspCodeActions lua vim.lsp.buf.code_action()")
  vim.cmd("command! LspReferences lua Snacks.picker.lsp_references()")
  vim.cmd("command! LspSymbols lua Snacks.picker.lsp_symbols()")
  vim.cmd("command! LspImplementations lua Snacks.picker.lsp_implementations()")
  vim.cmd("command! LspDiagList lua Snacks.picker.diagnostics()")
  vim.cmd(
    "command! LspDiagPrev lua vim.diagnostic.goto_prev({popup_opts = {focusable = false}})"
  )
  vim.cmd(
    "command! LspDiagNext lua vim.diagnostic.goto_next({popup_opts = {focusable = false}})"
  )
  vim.cmd("command! LspRename lua vim.lsp.buf.rename()")

  vim.cmd("augroup LspAutocommands")

  vim.cmd(
    [[autocmd CursorHold * lua vim.diagnostic.open_float({focusable = false, scope = "c"})]]
  )

  vim.cmd("augroup END")
end

return M
