return {
  -- use mini diff
  {
    "echasnovski/mini.diff",
    version = false,
    opts = {},
  },

  -- set tabwidth based on file type
  {
    "tpope/vim-sleuth",
    event = "VeryLazy",
  },

  -- highlight color codes
  {
    "catgoose/nvim-colorizer.lua",
    event = "VeryLazy",
    config = function()
      require("neotest").setup({
        names = false, -- red
      })
    end,
  },

  -- surround motions
  {
    "echasnovski/mini.surround",
    event = "User FilePost",
    opts = {},
  },

  -- cursor word
  {
    "sontungexpt/stcursorword",
    event = "VeryLazy",
    opts = {},
  },

  -- close pairs and tags
  {
    "windwp/nvim-autopairs",
    opts = {},
  },
  "windwp/nvim-ts-autotag",
}
