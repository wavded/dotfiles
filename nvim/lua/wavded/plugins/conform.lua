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
        css = { "bun_fmt" },
        go = { "golangci-lint" },
        graphql = { "bun_fmt" },
        html = { "bun_fmt" },
        java = { "google-java-format" },
        javascript = { "oxlint", "bun_fmt" },
        javascriptreact = { "oxlint", "bun_fmt" },
        json = { "bun_fmt" },
        jsonc = { "bun_fmt" },
        kotlin = { "ktlint" },
        less = { "bun_fmt" },
        lua = { "stylua" },
        markdown = { "bun_fmt" },
        rust = { "rustfmt" },
        scss = { "bun_fmt" },
        sql = { "sqruff" },
        svelte = { "bun_fmt" },
        toml = { "bun_fmt" },
        typescript = { "oxlint", "bun_fmt" },
        typescriptreact = { "oxlint", "bun_fmt" },
        yaml = { "bun_fmt" },
        ["yaml.jinja"] = { lsp_format = "never" },
      },
      format_on_save = { timeout_ms = 3000 },
      notify_no_formatters = false,
      formatters = {
        bun_fmt = {
          command = "bun",
          args = { "fmt", "--no-script", "--stdin-filepath", "$FILENAME" },
          stdin = true,
        },
        oxlint = { require_cwd = true, exit_codes = { 0, 1 } },
      },
    },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
}
