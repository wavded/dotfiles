vim.cmd(
  [[au FileType javascript,typescript,javascriptreact,typescriptreact map <leader>e :100split \| term NODE_ENV=test vitest run %<cr>]]
)
