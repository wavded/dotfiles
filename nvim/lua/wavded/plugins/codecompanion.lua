return {
  {
    "olimorris/codecompanion.nvim",
    lazy = false,
    opts = {
      adapters = {
        copilot = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = {
              model = {
                default = "claude-3.7-sonnet",
              },
            },
          })
        end,
      },
      prompt_library = {
        ["Auto-generate git commit message"] = {
          strategy = "inline",
          description = "Generate git commit message for current staged changes",
          opts = {
            mapping = "<LocalLeader>aacm",
            placement = "before|false",
          },
          prompts = {
            {
              role = "user",
              contains_code = true,
              content = function()
                return vim.fn.system("git diff --cached")
                  .. [[
Given the prior diff, write a git commit message. Follow these rules:

- The title should be 50 chars or less and capitalized.
- The description should start with 'Includes:' followed by a blank line and then a dashed list of changed.
- Write your commit message in the imperative.
- Use tick marks around variable and file names.
- Be concise and avoid redundancy.

Output only the commit message without any explanations and follow-up suggestions.
                    ]]
              end,
            },
          },
        },
      },
      strategies = {
        chat = {
          adapter = "copilot",
          roles = {
            llm = " Copilot ",
            user = " " .. vim.env.USER .. " ",
          },
        },
      },
    },
    keys = {
      { "<leader>cc", "<cmd>CodeCompanionChat<cr>" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
