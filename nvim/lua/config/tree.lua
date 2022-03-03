local u = require("util")

vim.g.nvim_tree_respect_buf_cwd = 1
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_icons = {
  default = "",
  symlink = "",
  git = {
    unstaged = "",
    staged = "",
    unmerged = "",
    renamed = "",
    untracked = "",
    deleted = "",
    ignored = "",
  },
  folder = {
    arrow_open = "",
    arrow_closed = "",
    default = "",
    open = "",
    empty = "",
    empty_open = "",
    symlink = "",
    symlink_open = "",
  },
}

local tree_cb = require("nvim-tree.config").nvim_tree_callback

require("nvim-tree").setup({
  auto_close = true,
  diagnostics = { enable = true },
  filters = { dotfiles = false },
  update_cwd = true,
  git = {
    ignore = false,
  },
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
  view = {
    mappings = {
      list = {
        { key = "mm", cb = tree_cb("rename") },
        { key = "mx", cb = tree_cb("cut") },
        { key = "mc", cb = tree_cb("copy") },
        { key = "md", cb = tree_cb("remove") },
        { key = "mo", cb = tree_cb("system_open") },
        { key = "ma", cb = tree_cb("create") },
      },
    },
  },
})

u.map("n", "<leader>n", ":NvimTreeFindFileToggle<cr>", { silent = true })
