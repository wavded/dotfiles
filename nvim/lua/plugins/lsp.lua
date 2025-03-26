return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "b0o/schemastore.nvim",
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "saghen/blink.cmp",
    },
    keys = {
      { "gd", "<cmd>lua Snacks.picker.lsp_definitions()<cr>" },
      { "gy", "<cmd>lua vim.lsp.buf.type_definitions()<cr>" },
      { "gr", "<cmd>lua Snacks.picker.lsp_references()<cr>" },
      { "gi", "<cmd>lua Snacks.picker.lsp_implementations()<cr>" },
      { "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>" },
      { "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>" },
      { "<space>cl", "<cmd>lua vim.lsp.codelens.run()<cr>" },
      { "<space>s", "<cmd>lua Snacks.picker.lsp_symbols()<cr>" },
      { "<space>d", "<cmd>lua Snacks.picker.diagnostics()<cr>" },
      { "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>" },
      { "[d", "<cmd>lua vim.diagnostic.goto_next()<cr>" },
    },
    opts = function()
      local util = require("lspconfig.util")
      local ret = {
        diagnostics = {
          underline = true,
          update_in_insert = false,
          virtual_text = {
            spacing = 4,
            source = "if_many",
            prefix = "●",
          },
          severity_sort = true,
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = "",
              [vim.diagnostic.severity.WARN] = "",
              [vim.diagnostic.severity.HINT] = "",
              [vim.diagnostic.severity.INFO] = "",
            },
          },
        },
        inlay_hints = { enabled = true },
        codelens = { enabled = true },
        capabilities = {
          workspace = {
            fileOperations = {
              didRename = true,
              willRename = true,
            },
          },
        },
        format = {
          formatting_options = nil,
          timeout_ms = nil,
        },
        servers = {
          lua_ls = {
            settings = {
              Lua = {
                workspace = {
                  library = { vim.env.VIMRUNTIME },
                  checkThirdParty = false,
                },
                codeLens = {
                  enable = true,
                },
                diagnostics = {
                  globals = { "vim" },
                },
                completion = {
                  callSnippet = "Replace",
                },
                doc = {
                  privateName = { "^_" },
                },
                hint = {
                  enable = true,
                  setType = false,
                  paramType = true,
                  paramName = "Disable",
                  semicolon = "Disable",
                  arrayIndex = "Disable",
                },
              },
            },
          },

          html = {},
          cssls = {},
          somesass_ls = {},
          vale_ls = {},
          gopls = {},
          kotlin_language_server = {},
          intelephense = {},
          rust_analyzer = {},

          golangci_lint_ls = {
            init_options = {
              command = {
                "golangci-lint",
                "run",
                "--output.json.path",
                "stdout",
                "--show-stats=false",
                "--issues-exit-code=1",
              },
            },
          },
          jdtls = {
            cmd_env = {
              ["JAVA_HOME"] = "/opt/homebrew/opt/java/libexec/openjdk.jdk/Contents/Home",
            },
          },
          jsonls = {
            settings = {
              json = {
                schemas = require("schemastore").json.schemas(),
              },
            },
          },
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
        },
      }
      return ret
    end,
    config = function(_, opts)
      local lspconfig = require("lspconfig")
      local blink = require("blink.cmp")

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client ~= nil and client.server_capabilities.codeLensProvider then
            vim.api.nvim_create_autocmd(
              { "BufEnter", "CursorHold", "InsertLeave" },
              {
                callback = vim.lsp.codelens.refresh,
                buffer = bufnr,
              }
            )
          end
          if
            client ~= nil
            and client.server_capabilities.inlayHintProvider
            and vim.api.nvim_buf_is_valid(bufnr)
            and vim.bo[bufnr].buftype == ""
          then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          end
        end,
      })

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
      vim.lsp.util.convert_input_to_markdown_lines = true
      vim.lsp.util.stylize_markdown = true

      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        blink.get_lsp_capabilities(),
        opts.capabilities
      )

      local servers = opts.servers

      for server, base_opts in pairs(servers) do
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, base_opts or {})

        if server_opts.enabled == false then
          return
        end

        lspconfig[server].setup(server_opts)
      end
    end,
  },
}
