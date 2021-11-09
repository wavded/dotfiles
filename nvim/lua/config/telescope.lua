local u = require("util")
local actions = require("telescope.actions")

require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<c-k>"] = actions.move_selection_previous,
        ["<c-j>"] = actions.move_selection_next,
      },
    },
  },
})

u.map("n", "<leader>g", ":Telescope find_files<cr>")
u.map("n", "<leader>f", ":Telescope live_grep<cr>")
u.map("n", "<leader>b", ":Telescope buffers<cr>")
u.map("n", "<leader>t", ":Telescope help_tags<cr>")
