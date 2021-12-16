local u = require("util")

-- KEY MAPPINGS --
vim.g.mapleader = ","
vim.g.localmapleader = ","

-- fast open current file in default application
u.map("n", "<leader>o", ":!open %<cr><cr>", { silent = true })

-- fast save/quit
u.map("n", "<leader>q", ":qa!%<cr>", { silent = true })

-- fast escaping
u.map("i", "<c>", "<esc>")

-- clear highlight
u.map("n", "<leader><space>", ":noh<cr>")

-- map Y to match C and D
u.map("n", "Y", "y$")

-- yank entire file (global yank)
u.map("n", "gy", "ggVGy")

-- ignore lines when going up or down
u.map("n", "j", "gj")
u.map("n", "k", "gk")

-- center next and prev search results
u.map("n", "n", "nzzzv")
u.map("n", "N", "Nzzzv")

-- center when moving up and down
u.map("n", "<c-d>", "<c-d>zz")
u.map("n", "<c-u>", "<c-u>zz")

-- center jumps
u.map("n", "''", "''zz")

-- cycle between buffers
u.map("n", "<leader>.", ":b#<cr>", { silent = true })

-- indent visual selected code without unselecting and going back to normal mode
u.map("v", ">", ">gv")
u.map("v", "<", "<gv")

-- fast editing of the .vimrc
u.map("n", "<leader>v", ":e $MYVIMRC<cr>")

-- gitup integration
u.map("n", "<leader>`", ":!gitup commit<cr><cr>", { silent = true })

-- alternate file
u.map("n", "<leader>a", ':lua require("alternate")()<cr>')

-- git messenger
u.map("n", "gm", ":GitMessenger<cr>")
