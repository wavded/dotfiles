local u = require("configs.utils")

local tree_cb = require("nvim-tree.config").nvim_tree_callback

require("nvim-tree").setup({
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
  renderer = {
    highlight_git = true,
    icons = {
      glyphs = {
        default = "",
        symlink = "",
        -- git = {
        --   unstaged = "",
        --   staged = "",
        --   unmerged = "",
        --   renamed = "",
        --   untracked = "",
        --   deleted = "",
        --   ignored = "",
        -- },
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
      },
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
