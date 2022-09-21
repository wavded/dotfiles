local catppuccin = require("catppuccin")
vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha

catppuccin.setup({
  integrations = {
    gitsigns = true,
    telescope = true,
    lsp_trouble = true,
    cmp = true,
    markdown = true,
    nvimtree = {
      enabled = true,
      show_root = true,
      transparent_panel = true,
    },
    ts_rainbow = true,
  },
})

vim.cmd([[colorscheme catppuccin]])
-- require("onedark").setup({
--   style = "deep",
-- })
-- require("onedark").load()
-- require("rose-pine").setup()
-- vim.cmd("colorscheme rose-pine")
