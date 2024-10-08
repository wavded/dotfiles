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
  gopls = {
    cmd_env = { GOFUMPT_SPLIT_LONG_LINES = "on" },
    settings = {
      gopls = {
        gofumpt = true,
      },
    },
  },
  html = {},
  eslint = {
    root_dir = util.root_pattern(".eslintrc"),
  },
  jdtls = {
    cmd_env = {
      ["JAVA_HOME"] = "/opt/homebrew/opt/java/libexec/openjdk.jdk/Contents/Home",
    },
    settings = {
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
  vtsls = {
    root_dir = util.root_pattern("package.json"),
    single_file_support = false,
    settings = {
      vtsls = {
        autoUseWorkspaceTsdk = true,
        experimental = {
          completion = {
            enableServerSideFuzzyMatch = true,
          },
        },
      },
      typescript = {
        updateImportsOnFileMove = { enabled = "always" },
        suggest = {
          completeFunctionCalls = true,
        },
        preferences = {
          useAliasesForRenames = false,
        },
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
        suggest = {
          completeFunctionCalls = true,
        },
        preferences = {
          useAliasesForRenames = false,
        },
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
  -- ts_ls = {
  --   root_dir = util.root_pattern("package.json"),
  --   single_file_support = false,
  -- },
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
