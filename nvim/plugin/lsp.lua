local servers = {
  cssls = {},
  html = {},
  jsonls = {},
  sumneko_lua = {
    settings = { Lua = { diagnostics = { globals = { "vim" } } } },
  },
  tsserver = {},
  gopls = {
    settings = { gopls = { gofumpt = true } },
  },
  vimls = {},
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    virtual_text = false,
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
  }
)

-- signs
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- lsp behavior
_G.lsp_organize_imports = function(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { "source.organizeImports" } }
  local result = vim.lsp.buf_request_sync(
    0,
    "textDocument/codeAction",
    params,
    wait_ms
  )
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit)
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

local bopts = { noremap = true, silent = true }
local function on_attach(client, id)
  vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
  vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting_sync()")
  vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
  vim.cmd(
    "command! LspCodeAction lua require'telescope.builtin'.lsp_code_actions()"
  )
  vim.cmd("command! LspOrganize lua require'util'.goimports()")
  vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
  vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
  vim.cmd("command! LspRefs lua require'telescope.builtin'.lsp_definitions()")
  vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
  vim.cmd(
    "command! LspImplementation lua require'telescope.builtin'.lsp_implementations()"
  )
  vim.cmd(
    "command! LspDiagPrev lua vim.lsp.diagnostic.goto_prev({popup_opts = {focusable = false}})"
  )
  vim.cmd(
    "command! LspDiagNext lua vim.lsp.diagnostic.goto_next({popup_opts = {focusable = false}})"
  )
  vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")

  local bmap = vim.api.nvim_buf_set_keymap
  bmap(id, "n", "gd", ":LspDef<cr>", bopts)
  bmap(id, "n", "<leader>rn", ":LspRename<cr>", bopts)
  bmap(id, "n", "gr", ":LspRefs<cr>", bopts)
  bmap(id, "n", "gy", ":LspTypeDef<cr>", bopts)
  bmap(id, "n", "K", ":LspHover<cr>", bopts)
  bmap(id, "n", "go", ":LspOrganize<cr>", bopts)
  bmap(id, "n", "<c-k>", ":LspDiagPrev<cr>", bopts)
  bmap(id, "n", "<c-j>", ":LspDiagNext<cr>", bopts)
  bmap(id, "n", "ga", ":LspCodeAction<cr>", bopts)
  bmap(id, "n", "<leader>a", ":LspDiagLine<cr>", bopts)
  bmap(id, "n", "gs", ":LspSignatureHelp<cr>", bopts)

  vim.cmd([[augroup LspAutocommands]])
  if client.resolved_capabilities.document_formatting then
    vim.cmd([[
      autocmd! * <buffer>
      autocmd BufWritePre <buffer> LspFormatting
    ]])
  end

  if client.resolved_capabilities.document_highlight == true then
    vim.cmd([[
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    ]])
  end

  -- diagnotics on hover
  vim.cmd(
    [[autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics({focusable = false})]]
  )

  -- nvim-lightbulb
  vim.cmd([[
		autocmd CursorHold,CursorHoldI <buffer> lua require"nvim-lightbulb".update_lightbulb {sign = {enabled = false}, virtual_text = {enabled = true, text = ""}, float = {enabled = false}}
  ]])

  vim.cmd([[ augroup END ]])
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits" },
}
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local options = {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

-- server installation
local lspi = require("nvim-lsp-installer")
local lspi_servers = require("nvim-lsp-installer.servers")

lspi.on_server_ready(function(server)
  local opts = vim.tbl_deep_extend("force", options, servers[server.name] or {})
  server:setup(opts)
  vim.cmd([[ do User LspAttachBuffers ]])
end)

for server, _ in pairs(servers) do
  local _, s = lspi_servers.get_server(server)
  if not s:is_installed() then
    s:install()
  end
end

local lspconfig = require("lspconfig")
local configs = require("lspconfig/configs")

-- add null-ls
lspconfig["null-ls"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- add golintci
if not lspconfig.golangcilsp then
  configs.golangcilsp = {
    default_config = {
      cmd = { "golangci-lint-langserver" },
      root_dir = lspconfig.util.root_pattern(".git", "go.mod"),
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
  }
end
lspconfig.golangcilsp.setup({
  filetypes = { "go" },
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
})
