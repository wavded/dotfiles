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
  },
})

vim.cmd([[colorscheme catppuccin]])
