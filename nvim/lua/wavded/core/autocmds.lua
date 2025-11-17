local function augroup(name)
  return vim.api.nvim_create_augroup("wavded_" .. name, { clear = true })
end

-- Auto save when focus lost (after tabbing away or switching buffers).
vim.cmd([[au FocusLost,BufLeave,WinLeave,TabLeave * silent! update"]])

-- Highlight when yanking text.
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup(
    "kickstart-highlight-yank",
    { clear = true }
  ),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Restore terminal cursor on exit.
vim.cmd([[au VimLeave * set guicursor=a:hor100-blinkon0]])

-- Add spelling and wrapping to certain file types.
vim.cmd([[au FileType gitcommit setlocal spell]])
vim.cmd([[au FileType markdown setlocal wrap spell]])
