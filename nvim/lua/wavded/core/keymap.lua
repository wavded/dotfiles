vim.g.mapleader = " "
vim.g.localmapleader = " "

vim.keymap.set(
  "n",
  "<leader>o",
  ":!open %<cr><cr>",
  { silent = true, desc = "Open current file in default application" }
)

vim.keymap.set(
  "n",
  "<leader><space>",
  ":noh<cr>",
  { silent = true, desc = "Clear highlights" }
)

-- Make Y behave like C and D.
vim.keymap.set("n", "Y", "y$", { desc = "Yank line" })
vim.keymap.set("n", "gy", "ggVGy", { desc = "Global yank" })

-- Ignore lines when going up or down.
vim.keymap.set("n", "j", "gj", { desc = "Go up one line" })
vim.keymap.set("n", "k", "gk", { desc = "Go down one line" })

-- Center next and prev search results.
vim.keymap.set("n", "n", "nzzzv", { desc = "Prev search result" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Next search result" })

-- Center when moving up and down.
vim.keymap.set("n", "<c-d>", "<c-d>zz", { desc = "Move down page" })
vim.keymap.set("n", "<c-u>", "<c-u>zz", { desc = "Move up page" })

-- Center jumps.
vim.keymap.set("n", "''", "''zz", { desc = "Jump" })

-- Cycle between buffers
vim.keymap.set("n", ",.", ":b#<cr>", { silent = true })

-- Indent visual selected code without unselecting and going back to normal mode.
vim.keymap.set("v", ">", ">gv", { desc = "Indent selection" })
vim.keymap.set("v", "<", "<gv", { desc = "Unindent selection" })

-- Gitup integration.
vim.keymap.set("n", "<leader>`", ":!gitup commit<cr><cr>", { silent = true })

-- Alternate file.
vim.keymap.set("n", "<leader>a", ':lua require("wavded.core.alternate")()<cr>')
