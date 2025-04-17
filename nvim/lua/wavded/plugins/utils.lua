return {
  -- set tabwidth based on file type
  {
    "tpope/vim-sleuth",
    event = "VeryLazy",
  },

  -- highlight color codes
  {
    "catgoose/nvim-colorizer.lua",
    event = "VeryLazy",
    opts = {},
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

  -- git gutter
  {
    "lewis6991/gitsigns.nvim",
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
