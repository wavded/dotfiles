return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "moon",
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  {
    "echasnovski/mini.icons",
    lazy = true,
    opts = {},
    -- init = function()
    --   -- Map icons to nvim-web-devicons for nvim-tree.
    --   package.preload["nvim-web-devicons"] = function()
    --     require("mini.icons").mock_nvim_web_devicons()
    --     return package.loaded["nvim-web-devicons"]
    --   end
    -- end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = "tokyonight",
      },
    },
  },
}
