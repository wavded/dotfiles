local snippy = require("snippy")
snippy.setup({
  mappings = {
    is = {
      ["<Tab>"] = "expand_or_advance",
      ["<S-Tab>"] = "previous",
    },
    nx = {
      ["<leader>x"] = "cut_text",
    },
  },
})

-- local luasnip = require("luasnip")

-- luasnip.config.set_config({
--   history = true,
--   updateevents = "TextChanged,TextChangedI",
-- })

-- require("luasnip/loaders/from_vscode").load()
