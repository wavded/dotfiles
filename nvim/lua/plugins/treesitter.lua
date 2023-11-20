local ts_configs = require("nvim-treesitter.configs")
ts_configs.setup({
  ensure_installed = {
    "bash",
    "comment",
    "css",
    "dockerfile",
    "go",
    "gomod",
    "gowork",
    "vimdoc",
    "html",
    "java",
    "javascript",
    "json",
    "kotlin",
    "lua",
    "make",
    "markdown",
    "php",
    "pug",
    "rust",
    "scss",
    "tsx",
    "typescript",
    "toml",
    "vim",
    "yaml",
  },
  highlight = {
    enable = true,
    use_languagetree = true,
    disable = function(_, bufnr)
      return vim.api.nvim_buf_line_count(bufnr) > 5000
    end,
  },
  indent = { enable = true },
  autotag = { enable = true },
  textsubjects = {
    enable = true,
    keymaps = { ["."] = "textsubjects-smart" },
  },
  -- rainbow = { enable = true },
})

require("ts_context_commentstring").setup({
  enable_autocmd = false,
})
