local u = require("configs.utils")

local tree_cb = require("nvim-tree.config").nvim_tree_callback

require("nvim-tree").setup({
  filters = {
    dotfiles = false,
    custom = { "node_modules", ".git", ".nyc_output" },
  },
  diagnostics = { enable = true },
  update_cwd = true,
  respect_buf_cwd = true,
  git = {
    ignore = false,
  },
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
  view = {
    width = "100%",
    mappings = {
      list = {
        { key = "mm", cb = tree_cb("rename") },
        { key = "mx", cb = tree_cb("cut") },
        { key = "mc", cb = tree_cb("copy") },
        { key = "md", cb = tree_cb("remove") },
        { key = "mo", cb = tree_cb("system_open") },
        { key = "ma", cb = tree_cb("create") },
        { key = "<esc>", cb = tree_cb("close") },
      },
    },
    float = {
      enable = true,
      open_win_config = {
        relative = "editor",
        border = "double",
        width = 1000,
        height = 1000,
        row = 1,
        col = 1,
      },
    },
  },
})

u.map("n", "<space>t", ":NvimTreeFindFileToggle<cr>", { silent = true })
