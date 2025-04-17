-- treesitter
return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    event = "VeryLazy",
    build = ":TSUpdate",
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    opts = {
      ensure_installed = {
        "bash",
        "comment",
        "css",
        "dockerfile",
        "gitcommit",
        "gitignore",
        "go",
        "gomod",
        "gowork",
        "html",
        "java",
        "javascript",
        "json",
        "jinja",
        "jinja_inline",
        "kotlin",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "php",
        "pug",
        "regex",
        "rust",
        "scss",
        "sql",
        "toml",
        "tsv",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
      auto_install = true,
      highlight = {
        enable = true,
        disable = function(_, bufnr)
          return vim.api.nvim_buf_line_count(bufnr) > 5000
        end,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      autotag = { enable = true },
      textsubjects = {
        enable = true,
        keymaps = { ["."] = "textsubjects-smart" },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    -- rainbow delimiters
    {
      "HiPhish/rainbow-delimiters.nvim",
      event = "VeryLazy",
      main = "rainbow-delimiters.setup",
      opts = {},
    },
  },
  {
    -- comments
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },
  -- plantuml syntax - no treesitter support
  {
    "aklt/plantuml-syntax",
    ft = "plantuml",
    init = function()
      vim.g.plantuml_executable_script =
        "PLANTUML_LIMIT_SIZE=8192 plantuml -tsvg -quiet $@"
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.icons",
    },
    ft = { "markdown", "copilot-chat", "codecompanion" },
    completions = { blink = { enabled = true } },
    opts = {
      code = {
        width = "block",
        left_pad = 2,
        right_pad = 2,
        sign = false,
      },
    },
  },
}
