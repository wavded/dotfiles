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
  },

  -- recall last cusor position
  {
    "farmergreg/vim-lastplace",
    event = "VeryLazy",
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

  {
    "vim-test/vim-test",
    config = function()
      vim.g["test#strategy"] = "neovim"
      vim.g["test#neovim#start_normal"] = 1
    end,
    keys = {
      { "<leader>e", "<cmd>TestFile<cr>" },
    },
  },
}
