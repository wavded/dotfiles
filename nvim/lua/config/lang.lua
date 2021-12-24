require("nvim-autopairs").setup({})
require("go").setup()

vim.cmd(
  [[au FileType javascript,typescript map <leader>e :100split \| term NODE_ENV=test TS_NODE_FILES=true nyc ts-node %<cr>]]
)

vim.g.git_messenger_no_default_mappings = true
