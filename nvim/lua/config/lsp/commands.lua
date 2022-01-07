local M = {}

function M.setup(client, _)
  vim.cmd(
    "command! LspDefinitions lua require'telescope.builtin'.lsp_definitions()"
  )
  vim.cmd(
    "command! LspCodeActions lua require'telescope.builtin'.lsp_code_actions()"
  )
  vim.cmd(
    "command! LspReferences lua require'telescope.builtin'.lsp_references()"
  )
  vim.cmd(
    "command! LspSymbols lua require'telescope.builtin'.lsp_document_symbols()"
  )
  vim.cmd(
    "command! LspImplementations lua require'telescope.builtin'.lsp_implementations()"
  )
  vim.cmd(
    "command! LspDiagPrev lua vim.diagnostic.goto_prev({popup_opts = {focusable = false}})"
  )
  vim.cmd(
    "command! LspDiagNext lua vim.diagnostic.goto_next({popup_opts = {focusable = false}})"
  )

  vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
  vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
  vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting_sync()")

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
    [[autocmd CursorHold * lua vim.diagnostic.open_float({focusable = false})]]
  )

  -- nvim-lightbulb
  -- vim.cmd([[
  -- autocmd CursorHold,CursorHoldI <buffer> lua require"nvim-lightbulb".update_lightbulb {sign = {enabled = false}, virtual_text = {enabled = true, text = ""}, float = {enabled = false}}
  -- ]])

  vim.cmd("augroup END")
end

return M
