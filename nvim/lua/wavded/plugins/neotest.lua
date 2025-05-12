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
    keys = {
      {
        ",tt",
        function()
          -- require("neotest").output_panel.clear()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
      },
      {
        ",tl",
        function()
          require("neotest").run.run()
        end,
      },
      {
        ",to",
        function()
          require("neotest").output_panel.toggle()
        end,
      },
    },
    config = function()
      require("neotest").setup({
        status = { virtual_text = true },
        quickfix = { enabled = false },
        output = { enabled = false },
        discovery = { enabled = false, concurrent = 1 },
        output_panel = {
          open = "botright vsplit | vertical resize 100",
        },
        consumers = {
          notify = function(client)
            client.listeners.run = function()
              require("neotest.lib").notify("Tests started")
            end
            client.listeners.results = function(_, _, partial)
              if partial then
                return
              end
              require("neotest.lib").notify("Tests completed")
            end
            return {}
          end,
        },
        adapters = {
          require("neotest-golang"),
          require("neotest-vitest"),
          -- ({
          --   is_test_file = function(path)
          --     return string.match(path, "_test")
          --   end,
          -- }),
        },
      })
    end,
  },
}
