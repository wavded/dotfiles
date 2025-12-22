return {
  {
    "olimorris/codecompanion.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      interactions = {
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
      rules = {
        default = {
          files = { "agents.md" },
          is_preset = true,
        },
        opts = {
          chat = {
            enabled = true,
            default_rules = "default",
            autoload = "default",
          },
        },
      },
      prompt_library = {
        markdown = {
          dirs = {
            "~/.config/nvim/prompts",
          },
        },
      },
      display = {
        action_palette = {
          opts = {
            show_preset_actions = true,
            show_preset_prompts = false,
            show_prompt_library_builtins = false,
          },
        },
        chat = {
          intro_message = "Press ? for options",
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
