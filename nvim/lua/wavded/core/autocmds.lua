local function augroup(name)
  return vim.api.nvim_create_augroup("wavded_" .. name, { clear = true })
end

-- Auto save when focus lost (after tabbing away or switching buffers).
vim.cmd([[au FocusLost,BufLeave,WinLeave,TabLeave * silent! update"]])

-- Go to last location when opening a buffer.
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("go_to_last_location"),
  callback = function()
    local exclude = { "gitcommit" }
    local buf = vim.api.nvim_get_current_buf()
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) then
      return
    end
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Restore terminal cursor on exit.
vim.cmd([[au VimLeave * set guicursor=a:hor100-blinkon0]])

vim.cmd([[au FileType python set noet]])
vim.cmd([[au BufRead,BufNewFile doc.go setlocal spell]])
vim.cmd([[au FileType gitcommit setlocal spell]])
vim.cmd([[au FileType markdown setlocal wrap spell]])
