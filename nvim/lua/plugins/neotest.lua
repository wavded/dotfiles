return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "marilari88/neotest-vitest",
      "fredrikaverpil/neotest-golang",
    },
    -- stylua: ignore
    keys = {
      { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end },
      { "<leader>tl", function() require("neotest").run.run() end },
      { "<leader>to", function() require("neotest").output_panel.toggle() end },
    },
    config = function()
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message = diagnostic.message
              :gsub("\n", " ")
              :gsub("\t", " ")
              :gsub("%s+", " ")
              :gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)

      require("neotest").setup({
        status = { virtual_text = true },
        quickfix = { enabled = false },
        output_panel = {
          open = "botright vsplit | vertical resize 100",
        },
        adapters = {
          require("neotest-golang")(),
          require("neotest-vitest")({
            is_test_file = function(path)
              return string.match(path, "_test")
            end,
          }),
        },
      })
    end,
  },
}
