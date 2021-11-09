local u = require("util")
local tree_cb = require'nvim-tree.config'.nvim_tree_callback

require('nvim-tree').setup {
  auto_close = true,
  diagnostics = { enable = true },
  filters = { dotfiles = true },
  update_cwd = true,
  view = {
    mappings = {
      list = {
        { key = "mm", cb = tree_cb("rename") },
        { key = "mx", cb = tree_cb("cut") },
        { key = "mc", cb = tree_cb("copy") },
        { key = "md", cb = tree_cb("remove") },
        { key = "mo", cb = tree_cb("system_open") },
        { key = "ma", cb = tree_cb("create") },
      }
    }
  }
}

vim.g.nvim_tree_quit_on_open = 1
vim.g.nvim_tree_respect_buf_cwd = 1
u.map("n", "<leader>n", ":NvimTreeToggle<cr>", { silent = true })
