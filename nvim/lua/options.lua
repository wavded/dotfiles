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
vim.opt.linebreak = true -- do not break wrap in the middle of words
vim.opt.updatetime = 250 -- millis before CursorHold event
vim.opt.showmode = false -- hide show mode status
vim.opt.signcolumn = "yes:1"
-- vim.opt.hlsearch = false

vim.opt.listchars = { tab = "  ", trail = "·" } -- show · for trailing space, \ \ for trailing tab
vim.opt.completeopt = { "menuone", "noselect" }
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
