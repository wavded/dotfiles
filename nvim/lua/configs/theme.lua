-- require("catppuccin").setup({
--   flavour = "macchiato",
--   integrations = {
--     cmp = true,
--     dashboard = false,
--     gitsigns = true,
--     hop = true,
--     markdown = true,
--     mason = true,
--     mini = true,
--     nvimtree = true,
--     telescope = true,
--     ts_rainbow = true,
--   },
-- })
--
-- vim.cmd([[colorscheme catppuccin]])

-- require("rose-pine").setup({
--   dark_variant = "moon",
-- })
-- vim.cmd("colorscheme rose-pine")

require("kanagawa").setup({
  compile = true, -- run :KanagawaCompile to see changes
  undercurl = true,
  commentStyle = { italic = true },
  functionStyle = {},
  keywordStyle = { italic = true },
  statementStyle = { bold = true },
  typeStyle = {},
  transparent = false,
  colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
  theme = "wave",
  background = {
    dark = "wave", -- try "dragon" !
    light = "lotus",
  },
})

-- setup must be called before loading
vim.cmd("colorscheme kanagawa")
