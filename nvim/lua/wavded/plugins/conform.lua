return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      default_format_opts = {
        lsp_format = "fallback",
      },
      formatters_by_ft = {
        css = { "oxfmt", "biome-check", "prettierd", stop_after_first = true },
        go = { "golangci-lint" },
        html = { "oxfmt", "biome-check", "prettierd", stop_after_first = true },
        java = { "google-java-format" },
        javascript = {
          "oxfmt",
          "biome-check",
          "prettierd",
          stop_after_first = true,
        },
        javascriptreact = {
          "oxfmt",
          "biome-check",
          "prettierd",
          stop_after_first = true,
        },
        json = { "oxfmt", "biome-check", "prettierd", stop_after_first = true },
        jsonc = { "oxfmt", "biome-check", "prettierd", stop_after_first = true },
        kotlin = { "ktlint" },
        lua = { "stylua" },
        markdown = { "oxfmt", "prettierd" },
        pug = { "prettierd" },
        rust = { "rustfmt" },
        scss = { "oxfmt", "prettierd" },
        sql = { "sqruff" },
        toml = { "oxfmt", "prettierd" },
        typescript = {
          "deno_fmt",
          "oxfmt",
          "biome-check",
          "prettierd",
          stop_after_first = true,
        },
        typescriptreact = {
          "oxfmt",
          "biome-check",
          "prettierd",
          stop_after_first = true,
        },
        yaml = { "oxfmt", "prettierd" },
      },
      format_on_save = { timeout_ms = 3000 },
      notify_no_formatters = false,
      formatters = {
        oxfmt = { require_cwd = true },
        ["biome-check"] = { require_cwd = true },
        deno_fmt = {
          cwd = function(self, ctx)
            local root = require("conform.util").root_file({
              "deno.json",
              "deno.jsonc",
            })
            return root(self, ctx)
          end,
          require_cwd = true,
        },
        prettierd = {
          condition = function(_, ctx)
            return string.match(vim.fs.basename(ctx.filename), ".sls") == nil
          end,
          require_cwd = true,
        },
      },
    },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
}
