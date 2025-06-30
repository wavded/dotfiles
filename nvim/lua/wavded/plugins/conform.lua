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
        css = { "biome-check", "prettierd", stop_after_first = true },
        go = { "golangci-lint" },
        html = { "biome-check", "prettierd", stop_after_first = true },
        java = { "google-java-format" },
        javascript = { "biome-check", "prettierd", stop_after_first = true },
        javascriptreact = {
          "biome-check",
          "prettierd",
          stop_after_first = true,
        },
        json = { "biome-check", "prettierd", stop_after_first = true },
        jsonc = { "biome-check", "prettierd", stop_after_first = true },
        lua = { "stylua" },
        markdown = { "prettierd" },
        pug = { "prettierd" },
        rust = { "rustfmt" },
        scss = { "prettierd" },
        typescript = {
          "deno_fmt",
          "biome-check",
          "prettierd",
          stop_after_first = true,
        },
        typescriptreact = {
          "biome-check",
          "prettierd",
          stop_after_first = true,
        },
        yaml = { "prettierd" },
      },
      format_on_save = { timeout_ms = 3000 },
      notify_no_formatters = false,
      formatters = {
        ["biome-check"] = {
          require_cwd = true,
        },
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
        eslint_d = {
          cwd = function(self, ctx)
            local root = require("conform.util").root_file({
              "eslint.config.js",
              "eslint.config.mjs",
              ".eslintrc",
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
