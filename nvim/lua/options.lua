vim.opt.termguicolors = true -- hicolor support and theme
vim.opt.swapfile = false -- no swap files
vim.opt.writebackup = true -- no write backup
vim.opt.autowrite = true -- save files automatically in most cases
vim.opt.ignorecase = true -- case insensitive search...
vim.opt.smartcase = true -- ...unless capitals are used
vim.opt.hidden = true -- allow background buffers w/out write
vim.opt.list = true -- show hidden characters
vim.opt.scrolloff = 3 -- show next 3 lines while scrolling
vim.opt.sidescrolloff = 5 -- show next 5 columns while side-scrolling
vim.opt.splitbelow = true -- more natural horizontal split
vim.opt.splitright = true -- more natural vertical split
vim.opt.clipboard = "unnamedplus" -- yanks puts it on clipboard
vim.opt.colorcolumn = "80" -- show a right margin column
vim.opt.expandtab = true -- use spaces, not tabs
vim.opt.shiftwidth = 2 -- set tab width
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.lazyredraw = true -- wait to redraw
vim.opt.pumheight = 10 -- completion window max size
vim.opt.wrap = false
vim.opt.linebreak = true -- do not break wrap in the middle of words
vim.opt.updatetime = 250 -- millis before CursorHold event
vim.opt.showmode = false -- hide show mode status
vim.opt.signcolumn = "yes:1"

-- vary cursor depending on mode
vim.opt.guicursor =
  "n-c:hor100-nCursor,v-sm:block,i-ci-ve:ver25-Cursor,r-cr-o:hor20,i-ci:ver30-iCursor-blinkwait300-blinkon200-blinkoff150"

-- show · for trailing space, \ \ for trailing tab
vim.opt.listchars = { tab = "  ", trail = "·" }

-- add more ignore patterns
vim.opt.wildignore:append({
  "*.o",
  ".git",
  "node_modules",
  ".nyc_output",
  "coverage",
  "target",
})

-- auto save when focus lost (after tabbing away or switching buffers)
vim.cmd([[au FocusLost,BufLeave,WinLeave,TabLeave * silent! update"]])

-- open files where last edits took place
vim.cmd(
  [[ au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif ]]
)

-- restore terminal cursor on exit
vim.cmd([[au VimLeave * set guicursor=a:hor100-blinkon0]])

-- configure some file types exceptions
vim.cmd([[au BufRead,BufNewFile .eslintrc setf json]])
vim.cmd([[au BufRead,BufNewFile .prettierrc setf json]])
vim.cmd([[au BufRead,BufNewFile .babelrc setf json]])
vim.cmd([[au BufRead,BufNewFile Jenkinsfile setf groovy]])
vim.cmd([[au FileType python set noet]])
vim.cmd([[au BufRead,BufNewFile doc.go setlocal spell]])
vim.cmd([[au FileType gitcommit setlocal spell]])
vim.cmd([[au FileType tagbar setlocal signcolumn=no]])
