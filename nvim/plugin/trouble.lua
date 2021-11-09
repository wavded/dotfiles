local u = require("util")
require("trouble").setup()
u.map("n", "<leader>d", ":Trouble<cr>", { silent = true })
