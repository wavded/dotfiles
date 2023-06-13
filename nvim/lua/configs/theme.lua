require("catppuccin").setup({
  flavour = "mocha",
  integrations = {
    cmp = true,
    dashboard = false,
    gitsigns = true,
    hop = true,
    markdown = true,
    mason = true,
    mini = true,
    nvimtree = true,
    telescope = true,
    ts_rainbow = true,
  },
})

vim.cmd([[colorscheme catppuccin]])

-- require("rose-pine").setup({
--   dark_variant = "moon",
-- })
-- vim.cmd("colorscheme rose-pine")
