return {
  {
    "reklai/colorrex.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "echasnovski/mini.icons",
    lazy = true,
    opts = {},
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = { options = { theme = "colorrex" } },
  },
}
