require("go").setup()

vim.cmd(
  [[au FileType javascript,typescript map <leader>e :100split \| term NODE_ENV=test TS_NODE_FILES=true nyc ts-node %<cr>]]
)
