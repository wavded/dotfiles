local M = {}

function M.setup(client, _)
  vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
  vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting_sync()")
  vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
  vim.cmd(
    "command! LspCodeAction lua require'telescope.builtin'.lsp_code_actions()"
  )
  vim.cmd("command! LspOrganize lua require'util'.goimports()")
  vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
  vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
  vim.cmd("command! LspRefs lua require'telescope.builtin'.lsp_definitions()")
  vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
  vim.cmd(
    "command! LspImplementation lua require'telescope.builtin'.lsp_implementations()"
  )
  vim.cmd(
    "command! LspDiagPrev lua vim.lsp.diagnostic.goto_prev({popup_opts = {focusable = false}})"
  )
  vim.cmd(
    "command! LspDiagNext lua vim.lsp.diagnostic.goto_next({popup_opts = {focusable = false}})"
  )
  vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")

  vim.cmd("augroup LspAutocommands")
  if client.resolved_capabilities.document_formatting then
    vim.cmd([[
      autocmd! * <buffer>
      autocmd BufWritePre <buffer> LspFormatting
    ]])
  end

  -- if client.resolved_capabilities.document_highlight == true then
  --   vim.cmd([[
  --     autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
  --     autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
  --   ]])
  -- end

  -- diagnotics on hover
  vim.cmd(
    [[autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics({focusable = false})]]
  )

  -- nvim-lightbulb
  -- vim.cmd([[
  -- autocmd CursorHold,CursorHoldI <buffer> lua require"nvim-lightbulb".update_lightbulb {sign = {enabled = false}, virtual_text = {enabled = true, text = ""}, float = {enabled = false}}
  -- ]])

  vim.cmd("augroup END")
end

return M
