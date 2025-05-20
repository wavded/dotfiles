return {
  {
    "olimorris/codecompanion.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      display = {
        action_palette = {
          opts = {
            show_default_actions = true,
            show_default_prompt_library = false,
          },
        },
      },
      prompt_library = {
        ["Commit"] = {
          strategy = "inline",
          description = "Generate git commit message for current staged changes",
          opts = {
            placement = "before|false",
          },
          prompts = {
            {
              role = "user",
              contains_code = true,
              content = function()
                return vim.fn.system("git diff --cached")
                  .. [[<user_prompt>
Write a git commit message. Follow these rules:

  - The title should be 50 chars or less and capitalized.
  - The description should start with 'Includes:' followed by a blank line and then a dashed list of changed.
  - Write using impertive language.
  - Be concise and avoid redundancy.
  - Add tick marks around any references to code.

Output only the commit message without any explanations and follow-up suggestions.
                </user_prompt>]]
              end,
            },
          },
        },
      },
    },
    keys = {
      { "<leader>cc", "<cmd>CodeCompanionActions<cr>" },
    },
  },
}
