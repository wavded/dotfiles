-- targets.vim replacement
require("mini.ai").setup()

-- surround.vim replacement
require("mini.surround").setup()

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

-- indent indicator
require("mini.indentscope").setup({ draw = { delay = 200 } })

-- indent indicator
require("mini.cursorword").setup({ delay = 200 })
