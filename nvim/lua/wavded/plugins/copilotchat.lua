return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    cmd = "CopilotChat",
    opts = function()
      local user = vim.env.USER or "User"
      return {
        -- model = "claude-3.7-sonnet",
        question_header = " " .. user .. " ",
        answer_header = " Copilot ",
        prompts = {
          -- Explain = {
          --   prompt = "Write an explanation for the selected code as paragraphs of text.",
          --   system_prompt = "COPILOT_EXPLAIN",
          -- },
          -- Review = {
          --   prompt = "Review the selected code.",
          --   system_prompt = "COPILOT_REVIEW",
          -- },
          -- Fix = {
          --   prompt = "There is a problem in this code. Identify the issues and rewrite the code with fixes. Explain what was wrong and how your changes address the problems.",
          -- },
          -- Optimize = {
          --   prompt = "Optimize the selected code to improve performance and readability. Explain your optimization strategy and the benefits of your changes.",
          -- },
          -- Docs = {
          --   prompt = "Please add documentation comments to the selected code.",
          -- },
          -- Tests = {
          --   prompt = "Please generate tests for my code.",
          -- },
          Commit = {
            prompt = [[
Write a git commit message. Follow these rules:

- The title should be 50 chars or less and capitalized.
- The description should start with 'Includes:' followed by a blank line and then a dashed list of changed.
- Write your commit message in the imperative.
- Use tick marks around variable and file names.
- Be concise and avoid redundancy.

Output only the commit message without any explanations and follow-up suggestions.
                    ]],
            context = "git:staged",
          },
        },
      }
    end,
    config = function(_, opts)
      local chat = require("CopilotChat")
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-chat",
        callback = function()
          vim.opt_local.relativenumber = false
          vim.opt_local.number = false
        end,
      })
      chat.setup(opts)
    end,
    keys = {
      { "<leader>cp", "<cmd>CopilotChatToggle<cr>" },
    },
  },
  {
    "saghen/blink.cmp",
    optional = true,
    opts = {
      sources = {
        providers = {
          path = {
            enabled = function()
              return vim.bo.filetype ~= "copilot-chat"
            end,
          },
        },
      },
    },
  },
}
