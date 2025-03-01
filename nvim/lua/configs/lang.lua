vim.cmd(
  [[au FileType javascript,typescript,javascriptreact,typescriptreact map <leader>e :100split \| term NODE_ENV=test vitest run %<cr>]]
)

vim.cmd([[au FileType go map <leader>e :GoTestFile<cr>]])

vim.g.plantuml_executable_script =
  "PLANTUML_LIMIT_SIZE=8192 plantuml -tsvg -quiet $@"
