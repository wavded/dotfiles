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
    init = function()
      -- Map icons to nvim-web-devicons for nvim-tree.
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      routes = {
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = { skip = true },
        },
      },
      views = {
        cmdline_popup = {
          border = {
            style = "none",
            padding = { 2, 3 },
          },
          filter_options = {},
          win_options = {
            winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
          },
        },
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
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
