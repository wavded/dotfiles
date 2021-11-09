local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  completion = { completeopt = "menu,menuone,noinsert" },

  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  formatting = {
    format = require("config.lsp.kind").cmp_format()
  },

  mapping = {
    ["<cr>"] = cmp.mapping.confirm(),
    ["<tab>"] = cmp.mapping(function(fallback)
      if luasnip.expand_or_jumpable() then
        luasnip.jump(1)
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<s-tab>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
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
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  },

  documentation = {
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  },
})
