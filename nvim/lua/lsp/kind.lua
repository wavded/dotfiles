local M = {}

M.icons = {
  Class = " ",
  Color = "",
  Constant = " ",
  Constructor = " ",
  Enum = "了 ",
  EnumMember = " ",
  Field = " ",
  File = " ",
  Folder = " ",
  Function = " ",
  Interface = "ﰮ ",
  Keyword = " ",
  Method = "ƒ ",
  Module = " ",
  Property = " ",
  Snippet = "﬌ ",
  Struct = " ",
  Text = " ",
  Unit = " ",
  Value = " ",
  Variable = " ",
}

function M.cmp_format()
  return function(entry, item)
    if M.icons[item.kind] then
      item.kind = M.icons[item.kind] .. item.kind
    end
    item.menu = ({
      nvim_lsp = "LSP",
      snippy = "SNIP",
      path = "PATH",
      buffer = "BUF",
      rg = "RG",
      tmux = "TMUX",
    })[entry.source.name]
    return item
  end
end

function M.setup()
  local kinds = vim.lsp.protocol.CompletionItemKind
  for i, kind in ipairs(kinds) do
    kinds[i] = M.icons[kind] or kind
  end
end

return M
