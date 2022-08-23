vim.cmd(
  [[au FileType javascript,typescript map <leader>e :100split \| term NODE_ENV=test TS_NODE_FILES=true nyc ts-node %<cr>]]
)

vim.g.plantuml_executable_script =
  "PLANTUML_LIMIT_SIZE=8192 plantuml -tsvg -quiet $@"
