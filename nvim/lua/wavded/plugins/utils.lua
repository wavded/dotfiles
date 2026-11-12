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
      vim.cmd([[
        function! TestLoadEnv(cmd) abort
          return 'if [ -f .env ]; then set -a; . ./.env || exit; set +a; fi; ' . a:cmd
        endfunction
        let g:test#custom_transformations = {'dotenv': function('TestLoadEnv')}
        let g:test#transformation = 'dotenv'
      ]])
    end,
    keys = {
      { "<leader>e", "<cmd>TestFile<cr>" },
    },
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    opts = {
      preset = "classic",
      options = {
        -- add_messages = {
        --   display_count = true,
        -- },
        show_source = {
          enabled = true,
        },
        -- multilines = {
        --   enabled = true,
        --   always_show = true,
        -- },
      },
    },
  },
}
