return {
  {
    "olimorris/codecompanion.nvim",
    opts = {
      strategies = {
        chat = {
          adapter = "copilot",
          slash_commands = {
            ["file"] = {
              opts = {
                provider = "fzf_lua",
              },
            },
            ["buffer"] = {
              opts = {
                provider = "fzf_lua",
              },
            },
            ["help"] = {
              opts = {
                provider = "fzf_lua",
              },
            },
            ["symbols"] = {
              opts = {
                provider = "fzf_lua",
              },
            },
          },
        },
        inline = {
          adapter = "copilot",
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
