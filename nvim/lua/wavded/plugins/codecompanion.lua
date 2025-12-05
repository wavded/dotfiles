return {
  {
    "olimorris/codecompanion.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      ignore_warnings = true,
      strategies = {
        chat = {
          roles = {
            llm = function(adapter)
              return adapter.formatted_name .. " (" .. adapter.model.name .. ")"
            end,
          },
          tools = {
            opts = {
              default_tools = { "full_stack_dev" },
              auto_submit_errors = true,
              auto_submit_success = true,
            },
          },
        },
      },
      memory = {
        opts = {
          chat = {
            enabled = true,
          },
        },
      },
      display = {
        action_palette = {
          opts = {
            show_default_actions = true,
            show_default_prompt_library = false,
          },
        },

        chat = {
          intro_message = "Press ? for options",
        },
      },
      prompt_library = {
        ["Commit"] = {
          strategy = "inline",
          description = "Generate git commit message for current staged changes",
          opts = {
            placement = "before|false",
            adapter = {
              name = "copilot",
              model = "gemini-3-pro-preview",
            },
          },
          prompts = {
            {
              role = "user",
              contains_code = true,
              content = function()
                return vim.fn.system("git diff --cached")
                  .. [[<prompt>
Write a git commit message. Follow these rules:

  - The title should be 50 chars or less and sentence case.
  - The title should not be prefixed with 'feat', 'fix', etc.
  - The description should start with 'Includes:' followed by a blank line and then a dashed list of changed.
  - Write using impertive language.
  - Be concise and avoid redundancy.
  - Add tick marks around any references to code.

Output only the commit message without any explanations and follow-up suggestions.
                </prompt>]]
              end,
            },
          },
        },
      },
    },
    keys = {
      {
        "<leader>cc",
        "<cmd>CodeCompanionActions<cr>",
        mode = { "n", "v" },
      },
      {
        "<leader>cp",
        "<cmd>CodeCompanion /copilot<cr>",
        mode = { "n" },
      },
      {
        "<leader>q",
        "<cmd>CodeCompanionChat Toggle<cr>",
        mode = { "n", "v" },
      },
      { "<leader>cb", ":%CodeCompanion<cr>", mode = "n" },
      { "ga", "<cmd>CodeCompanionChat Add<cr>", mode = "v" },
      { "gi", ":'<,'>CodeCompanion<cr>", mode = "v" },
    },
  },
}
