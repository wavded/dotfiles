local M = {}

function M.setup(_, buf)
  local bmap = vim.api.nvim_buf_set_keymap
  local bopts = { noremap = true, silent = true }

  bmap(buf, "n", "gd", ":LspDefinition<cr>", bopts)
  bmap(buf, "n", "gy", ":LspTypeDefinition<cr>", bopts)
  bmap(buf, "n", "<leader>rn", ":LspRename<cr>", bopts)
  bmap(buf, "n", "gr", ":LspReferences<cr>", bopts)
  bmap(buf, "n", "gi", ":LspImplementations<cr>", bopts)
  bmap(buf, "n", "K", ":LspHover<cr>", bopts)
  bmap(buf, "n", "[d", ":LspDiagPrev<cr>", bopts)
  bmap(buf, "n", "]d", ":LspDiagNext<cr>", bopts)
  bmap(buf, "n", "<space>ac", ":LspCodeActions<cr>", bopts)
  bmap(buf, "n", "<space>s", ":LspSymbols<cr>", bopts)
  bmap(buf, "n", "<space>d", ":LspDiagList<cr>", bopts)
  bmap(buf, "i", "<c-x><c-x>", "<cmd> LspSignatureHelp<cr>", bopts)
end

return M
