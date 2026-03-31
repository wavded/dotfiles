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
        css = { "oxfmt" },
        go = { "golangci-lint" },
        html = { "oxfmt" },
        java = { "google-java-format" },
        javascript = { "oxlint", "oxfmt" },
        javascriptreact = { "oxlint", "oxfmt" },
        json = { "oxfmt" },
        jsonc = { "oxfmt" },
        kotlin = { "ktlint" },
        lua = { "stylua" },
        markdown = { "oxfmt" },
        pug = { "prettierd" },
        rust = { "rustfmt" },
        scss = { "oxfmt" },
        sql = { "sqruff" },
        toml = { "oxfmt" },
        typescript = { "deno_fmt", "oxlint", "oxfmt" },
        typescriptreact = { "oxlint", "oxfmt" },
        yaml = { "oxfmt" },
      },
      format_on_save = { timeout_ms = 3000 },
      notify_no_formatters = false,
      formatters = {
        oxlint = { require_cwd = true, exit_codes = { 0, 1 } },
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
      },
    },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
}
