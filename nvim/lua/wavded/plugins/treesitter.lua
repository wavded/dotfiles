return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    version = false,
    build = ":TSUpdate",
    cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = {
        "bash",
        "comment",
        "css",
        "diff",
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
    },
    config = function(_, opts)
      local TS = require("nvim-treesitter")
      TS.install(opts.ensure_installed)
      TS.setup(opts)
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local ok = pcall(vim.treesitter.start)
          if ok then
            vim.bo[args.buf].indentexpr =
              "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
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
    ft = { "markdown", "codecompanion" },
    completions = { blink = { enabled = true } },
    opts = {
      render_modes = true,
      heading = {
        sign = false,
        position = "inline",
        right_pad = 10,
      },
      code = {
        position = "right",
        width = "block",
        border = "thick",
        language_pad = 1,
        left_pad = 2,
        right_pad = 2,
        min_width = 70,
        sign = false,
      },
      overrides = {
        buftype = {
          -- Clean up popup windows.
          nofile = {
            code = {
              border = "hide",
              style = "normal",
              left_pad = 0,
              right_pad = 0,
            },
          },
        },
      },
    },
  },
}
