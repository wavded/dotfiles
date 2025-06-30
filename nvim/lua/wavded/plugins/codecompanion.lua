return {
  {
    "olimorris/codecompanion.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      opts = {
        system_prompt = function(opts)
          return [[You are an AI programming assistant named Barky. You are currently plugged into the Neovim text editor on a user's machine.

You must:
- Follow the user's requirements carefully.
- Use the context and attachments the user provides.
- Keep your answers concise and impersonal.
- Minimize additional prose unless clarification is needed.
- Use Markdown formatting in your answers.
- Use Markdown codeblocks for any code snippets you provide.
- Do not include line numbers in code blocks.
- Avoid using H1, H2 or H3 headers in your responses as these are reserved for the user.
- Use actual line breaks in your responses; only use "\n" when you want a literal backslash followed by 'n'.
- Multiple, different tools can be called as part of the same response.

When given a task:
1. Think step-by-step and, unless the user requests otherwise or the task is very simple, describe your plan in detailed pseudocode.
2. Output the final code in a single code block, ensuring that only relevant code is included.
3. End your response with a short suggestion for the next user turn that directly supports continuing the conversation.
4. Provide exactly one complete reply per conversation turn.
5. If necessary, execute multiple tools in a single turn.]]
        end,
      },
      strategies = {
        chat = {
          roles = {
            llm = function(adapter)
              return "Barky (" .. adapter.formatted_name .. ")"
            end,

            user = "Me",
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
      },
      prompt_library = {
        ["With Copilot Instructions"] = {
          strategy = "chat",
          description = "Include Copilot instructions in the prompt",
          opts = {
            mapping = "<leader>cp",
            short_name = "copilot",
            mode = { "n", "v" },
          },
          references = {
            {
              type = "file",
              path = ".github/copilot-instructions.md",
            },
          },
          prompts = {
            {
              role = "user",
              content = "#{buffer} \n\n ",
            },
          },
        },
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
                  .. [[<prompt>
Write a git commit message. Follow these rules:

  - The title should be 50 chars or less and capitalized.
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
      { "ga", "<cmd>CodeCompanionChat Add<cr>", mode = "v" },
      { "gi", ":'<,'>CodeCompanion<cr>", mode = "v" },
    },
  },
}
