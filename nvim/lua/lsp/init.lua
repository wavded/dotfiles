require("lsp.diagnostics")
require("lsp.kind").setup()

local lspconfig = require("lspconfig")
local util = require("lspconfig.util")

local servers = {
  cssls = {},
  denols = {
    root_dir = util.root_pattern("deno.json"),
    single_file_support = false,
  },
  golangci_lint_ls = {
    init_options = {
      command = {
        "golangci-lint",
        "run",
        "--enable",
        "gosec",
        "--disable",
        "lll",
        "--out-format",
        "json",
      },
    },
  },
  gopls = {},
  html = {
    init_options = {
      configurationSection = { "html", "css", "javascript" },
      embeddedLanguages = {
        css = true,
        javascript = true,
      },
      provideFormatter = false,
    },
  },
  eslint = {
    root_dir = util.root_pattern(".eslintrc"),
  },
  jdtls = {
    cmd_env = {
      ["JAVA_HOME"] = "/opt/homebrew/opt/java/libexec/openjdk.jdk/Contents/Home",
    },
    settings = {
      -- ["java.format.settings.url"] = "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml",
      ["java.format.enabled"] = false,
    },
  },
  jsonls = {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
      },
    },
  },
  kotlin_language_server = {},
  phpactor = {},
  rust_analyzer = {},
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim", "hs" },
          disable = { "lowercase-global" },
        },
      },
    },
  },
  tsserver = {
    root_dir = util.root_pattern("package.json"),
    single_file_support = false,
  },
}

local function on_attach(client, buf)
  -- require("lsp_signature").on_attach({
  --   bind = true,
  --   hint_prefix = " ",
  -- })
  require("lsp.commands").setup(client, buf)
  require("lsp.formatting").setup(client, buf)
  require("lsp.keys").setup(client, buf)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits" },
}
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local shared_opts = {
  on_attach = on_attach,
  capabilities = capabilities,
}

for name, opts in pairs(servers) do
  local config = vim.tbl_deep_extend("force", shared_opts, opts or {})
  lspconfig[name].setup(config)
end

require("lsp.null-ls").setup(shared_opts)
