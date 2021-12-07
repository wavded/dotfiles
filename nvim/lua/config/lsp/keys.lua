local M = {}

function M.setup(_, buf)
  local bmap = vim.api.nvim_buf_set_keymap
  local bopts = { noremap = true, silent = true }

  bmap(buf, "n", "gd", ":LspDefinitions<cr>", bopts)
  bmap(buf, "n", "<leader>rn", ":LspRename<cr>", bopts)
  bmap(buf, "n", "gr", ":LspReferences<cr>", bopts)
  bmap(buf, "n", "gi", ":LspImplementations<cr>", bopts)
  bmap(buf, "n", "K", ":LspHover<cr>", bopts)
  bmap(buf, "n", "<c-k>", ":LspDiagPrev<cr>", bopts)
  bmap(buf, "n", "<c-j>", ":LspDiagNext<cr>", bopts)
  bmap(buf, "n", "ga", ":LspCodeActions<cr>", bopts)
  bmap(buf, "n", "<leader>s", ":LspSymbols<cr>", bopts)
end

return M
