-- targets.vim replacement
require("mini.ai").setup()

-- commentary.vim replacement
require("mini.comment").setup({
  hooks = {
    pre = function()
      require("ts_context_commentstring.internal").update_commentstring()
    end,
  },
})

-- autopairs
require("mini.pairs").setup()
