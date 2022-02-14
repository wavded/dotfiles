local catppuccin = require("catppuccin")

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
    },
    ts_rainbow = true,
  },
})

vim.cmd([[colorscheme catppuccin]])
