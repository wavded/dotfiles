require("nvim-autopairs").setup({})
require("go").setup({
  max_line_len = 80,
  tag_transform = false,
})

vim.cmd([[autocmd BufWritePre *.go :silent! lua require('go.format').gofmt()]])

vim.cmd(
  [[au FileType javascript,typescript map <leader>e :100split \| term NODE_ENV=test TS_NODE_FILES=true nyc ts-node %<cr>]]
)

vim.g.git_messenger_no_default_mappings = true

vim.g.plantuml_executable_script =
  "PLANTUML_LIMIT_SIZE=8192 plantuml -tsvg -quiet $@"
