return {
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      picker = {
        win = {
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "i", "n" } },
            },
          },
        },
        sources = {
          explorer = {
            auto_close = true,
          },
        },
      },
      bigfile = {},
      explorer = {},
    },
    keys = {
      { "<space>f", "<cmd>lua Snacks.picker.smart()<cr>" },
      { "<space>b", "<cmd>lua Snacks.picker.buffers()<cr>" },
      { "<space>/", "<cmd>lua Snacks.picker.grep()<cr>" },
      { "<space>u", "<cmd>lua Snacks.picker.undo()<cr>" },
      { "<space>r", "<cmd>lua Snacks.picker.resume()<cr>" },
      { "<space>t", "<cmd>lua Snacks.explorer()<cr>" },
    },
  },
}
