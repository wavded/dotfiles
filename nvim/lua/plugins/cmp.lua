local u = require("configs.utils")
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

  window = {
    documentation = cmp.config.window.bordered(),
  },

  formatting = {
    format = require("lsp.kind").cmp_format(),
  },

  mapping = {
    ["<tab>"] = cmp.mapping(function(fallback)
      if snippy.can_expand_or_advance() then
        snippy.expand_or_advance()
      elseif check_back_space() then
        vim.fn.feedkeys(u.t("<tab>"), "n")
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<s-tab>"] = cmp.mapping(function(fallback)
      if snippy.can_jump(-1) then
        snippy.previous()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<c-n>"] = cmp.mapping(function()
      cmp.select_next_item()
    end, { "i", "s" }),
    ["<c-p>"] = cmp.mapping(function()
      cmp.select_prev_item()
    end, { "i", "s" }),
    ["<c-e>"] = cmp.mapping(function()
      cmp.abort()
    end, { "i", "s" }),
    ["<c-y>"] = cmp.mapping(function()
      cmp.confirm()
    end, { "i", "s" }),
    ["<cr>"] = cmp.mapping(function(fallback)
      if cmp.get_selected_entry() then
        cmp.confirm()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<c-j>"] = cmp.mapping.complete(),
  },

  sources = cmp.config.sources({
    { name = "nvim_lsp_signature_help", priority = 9999 },
    {
      name = "snippy",
      priority = 9999,
      keyword_length = 2,
      max_item_count = 1,
    },
    { name = "nvim_lsp", keyword_length = 2, priority = 9998 },
    { name = "rg", keyword_length = 3 },
    { name = "buffer", keyword_length = 3 },
    { name = "path" },
  }),
})
