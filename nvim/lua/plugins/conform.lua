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
        css = { "prettierd" },
        go = { "goimports", "gofumpt" },
        html = { "prettierd" },
        java = { "google-java-format" },
        javascript = { "eslint_d", "prettierd" },
        javascriptreact = { "eslint_d", "prettierd" },
        json = { "prettierd" },
        jsonc = { "prettierd" },
        lua = { "stylua" },
        markdown = { "prettierd" },
        pug = { "prettierd" },
        rust = { "rustfmt" },
        scss = { "prettierd" },
        typescript = { "eslint_d", "prettierd", "deno_fmt" },
        typescriptreact = { "eslint_d", "prettierd" },
        yaml = { "prettierd" },
      },
      format_on_save = { timeout_ms = 3000 },
      notify_no_formatters = false,
      formatters = {
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
        },
        gofumpt = {
          env = {
            GOFUMPT_SPLIT_LONG_LINES = "on",
          },
        },
      },
    },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
}
