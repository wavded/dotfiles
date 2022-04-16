local u = require("util")
local cmp = require("cmp")
local snippy = require("snippy")

local check_back_space = function()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
end

cmp.setup({
  preselect = cmp.PreselectMode.None,

  snippet = {
    expand = function(args)
      snippy.expand_snippet(args.body)
    end,
  },

  formatting = {
    format = require("config.lsp.kind").cmp_format(),
  },

  mapping = {
    ["<cr>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
    ["<c-j>"] = cmp.mapping.complete(),
    ["<tab>"] = cmp.mapping(function(fallback)
      if snippy.can_expand_or_advance() then
        snippy.expand_or_advance()
      elseif check_back_space() then
        vim.fn.feedkeys(u.t("<tab>"), "n")
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<s-tab>"] = cmp.mapping(function(fallback)
      if snippy.can_jump(-1) then
        snippy.previous()
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  },

  sources = {
    { name = "nvim_lsp" },
    { name = "snippy" },
    { name = "buffer" },
    { name = "path" },
    { name = "rg", keyword_length = 5 },
  },

  window = {
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },
  },
})
