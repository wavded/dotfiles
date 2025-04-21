vim.g.loaded_netrw = 1 -- disable netrw, using another file tree
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true -- hicolor support and theme
vim.opt.swapfile = false -- no swap files
vim.opt.writebackup = true -- no write backup
vim.opt.autowrite = true -- save files automatically in most cases
vim.opt.ignorecase = true -- case insensitive search...
vim.opt.smartcase = true -- ...unless capitals are used
vim.opt.hidden = true -- allow background buffers w/out write
vim.opt.scrolloff = 10 -- show next 3 lines while scrolling
vim.opt.sidescrolloff = 5 -- show next 5 columns while side-scrolling
vim.opt.splitbelow = true -- more natural horizontal split
vim.opt.splitright = true -- more natural vertical split
-- vim.opt.colorcolumn = "80" -- show a right margin column
vim.opt.expandtab = true -- use spaces, not tabs
vim.opt.shiftwidth = 2 -- set tab width
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.pumheight = 10 -- completion window max size
vim.opt.wrap = false
vim.opt.linebreak = true -- do not break wrap in the middle of words
vim.opt.updatetime = 250 -- millis before CursorHold event
vim.opt.showmode = false -- hide show mode status
vim.opt.signcolumn = "yes:1"
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.encoding = "utf-8" -- set encoding
vim.opt.timeoutlen = 300 -- mapped sequence wait time

-- use os clipboard, scheduled to reduce startup time
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

-- vary cursor depending on mode
vim.opt.guicursor =
  "n-c:hor100-nCursor,v-sm:block,i-ci-ve:ver25-Cursor,r-cr-o:hor20,i-ci:ver30-iCursor-blinkwait300-blinkon200-blinkoff150"

vim.opt.list = true -- show hidden characters
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- add more ignore patterns
vim.opt.wildignore:append({
  "*.o",
  ".git",
  "node_modules",
  ".nyc_output",
  "coverage",
  "target",
})

-- configure some file types exceptions
vim.filetype.add({
  filename = {
    Jenkinsfile = "groovy",
  },
  extension = {
    sls = "yaml",
    neon = "yaml",
    prettierrc = "json",
    eslintrc = "json",
    jinja = "jinja",
  },
})
