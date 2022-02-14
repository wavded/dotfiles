local ts_configs = require("nvim-treesitter.configs")
ts_configs.setup({
  ensure_installed = "maintained",
  highlight = { enable = true, use_languagetree = true },
  indent = { enable = true },
  context_commentstring = {
    enable = true,
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  },
})
