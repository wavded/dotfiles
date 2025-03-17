local u = require("configs.utils")

-- finder
return {
  {
    "ibhagwan/fzf-lua",
    event = "VeryLazy",
    opts = {
      keymap = {
        fzf = {
          ["ctrl-q"] = "select-all+accept",
        },
      },
      winopts = {
        height = 0.95,
        width = 0.95,
        preview = {
          scrollbar = false,
        },
      },
      fzf_opts = {
        ["--layout"] = "default",
      },
      file_ignore_patterns = { "pnpm.lock" },
      files = {
        actions = {
          ["ctrl-e"] = function(selected)
            for i, item in ipairs(selected) do
              local command = i == 1 and "edit"
                or i % 2 == 0 and "vsplit"
                or "split"
              vim.cmd(string.format("%s %s", command, item))
            end
          end,
        },
      },
    },
    config = function(_, opts)
      require("fzf-lua").setup(opts)
      u.map("n", "<space>f", ":FzfLua files<cr>", { silent = true })
      u.map("n", "<space>b", ":FzfLua buffers<cr>", { silent = true })
      u.map("n", "<space>/", ":FzfLua live_grep_glob<cr>", { silent = true })
      u.map("n", "<space>r", ":FzfLua resume<cr>", { silent = true })
    end,
  },
}
