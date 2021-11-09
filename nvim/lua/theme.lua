vim.cmd("colorscheme nightfly")

vim.g.nightflyNormalFloat = 1
vim.g.nightflyUndercurls = 1

require("lualine").setup({ options = { theme = "nightfly" } })
