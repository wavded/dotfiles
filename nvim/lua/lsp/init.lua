require("lsp.diagnostics")

local lspconfig = require("lspconfig")
local util = require("lspconfig.util")

local servers = {
  html = {},
  cssls = {},
  somesass_ls = {},
  jsonls = {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
      },
    },
  },
  vale_ls = {},
  denols = {
    root_dir = util.root_pattern("deno.json", "deno.jsonc"),
    single_file_support = false,
  },
  eslint = {
    root_dir = util.root_pattern(
      "eslint.config.js",
      "eslint.config.mjs",
      ".eslintrc"
    ),
    single_file_support = false,
  },
  vtsls = {
    root_dir = util.root_pattern("package.json"),
    single_file_support = false,
    settings = {
      vtsls = {
        autoUseWorkspaceTsdk = true,
        experimental = {
          completion = { enableServerSideFuzzyMatch = true },
        },
      },
      typescript = {
        updateImportsOnFileMove = { enabled = "always" },
        suggest = { completeFunctionCalls = true },
        preferences = { useAliasesForRenames = false },
        inlayHints = {
          enumMemberValues = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          parameterNames = { enabled = "literals" },
          parameterTypes = { enabled = true },
          propertyDeclarationTypes = { enabled = true },
          variableTypes = { enabled = false },
        },
      },
      javascript = {
        updateImportsOnFileMove = { enabled = "always" },
        suggest = { completeFunctionCalls = true },
        preferences = { useAliasesForRenames = false },
        inlayHints = {
          enumMemberValues = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          parameterNames = { enabled = "literals" },
          parameterTypes = { enabled = true },
          propertyDeclarationTypes = { enabled = true },
          variableTypes = { enabled = false },
        },
      },
    },
  },

  gopls = {},
  jdtls = {
    cmd_env = {
      ["JAVA_HOME"] = "/opt/homebrew/opt/java/libexec/openjdk.jdk/Contents/Home",
    },
  },
  kotlin_language_server = {},
  intelephense = {},
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
}

local function on_attach(client, buf)
  require("lsp.commands").setup(client, buf)
  require("lsp.keys").setup(client, buf)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits" },
}

vim.lsp.util.convert_input_to_markdown_lines = true
vim.lsp.util.stylize_markdown = true

local shared_opts = {
  inlay_hints = {
    enabled = true,
  },
  on_attach = on_attach,
  capabilities = capabilities,
}

for name, opts in pairs(servers) do
  local config = vim.tbl_deep_extend("force", shared_opts, opts or {})
  config.capabilities = require("blink.cmp").get_lsp_capabilities()
  lspconfig[name].setup(config)
end
