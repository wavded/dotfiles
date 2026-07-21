return {
  {
    "olimorris/codecompanion.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      adapters = {
        http = {
          copilot = function()
            return require("codecompanion.adapters").extend("copilot", {
              headers = {
                ["Authorization"] = function()
                  local token =
                    vim.fn.system("gh auth token 2>/dev/null"):gsub("%s+", "")
                  if token and token ~= "" then
                    return "Bearer " .. token
                  end
                  return nil
                end,
              },
            })
          end,
        },
      },
      interactions = {
        chat = {
          adapter = {
            name = "copilot",
            model = "gemini-3.6-flash",
          },
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
        inline = {
          adapter = {
            name = "copilot",
            model = "gemini-3.6-flash",
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
            show_preset_prompts = true,
            show_prompt_library_builtins = true,
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
