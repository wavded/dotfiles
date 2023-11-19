local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

function use(name)
  return function()
    require("plugins." .. name)
  end
end

require("lazy").setup({
  "tpope/vim-sleuth", -- set tabwidth based on file type
  "tpope/vim-eunuch", -- unix commands (:SudoWrite)
  { "lewis6991/gitsigns.nvim", config = use("gitsigns") }, -- git gutter
  { "phaazon/hop.nvim", config = use("hop") }, -- motion
  { "echasnovski/mini.nvim", config = use("mini") },
  { "nvim-lualine/lualine.nvim", config = use("lualine") }, -- status line
  { "dcampos/nvim-snippy", config = use("snippy") }, -- snippets

  -- lsp
  { "williamboman/mason.nvim", build = ":MasonUpdate", config = use("mason") },
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig", -- makes lsp configuration easier
  "b0o/schemastore.nvim", -- simple access to json-language-server schemae
  "nvimtools/none-ls.nvim", -- non lsp support

  -- completion
  { "hrsh7th/nvim-cmp", config = use("cmp") },
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lsp-signature-help",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "dcampos/cmp-snippy",
  "lukas-reineke/cmp-rg",

  -- helpers
  "nvim-lua/plenary.nvim",
  "kyazdani42/nvim-web-devicons",
  { "ray-x/guihua.lua", build = "cd lua/fzy && make" },

  -- global find / replace
  "nvim-pack/nvim-spectre",

  -- file tree
  { "kyazdani42/nvim-tree.lua", config = use("tree") },
  { "ibhagwan/fzf-lua", config = use("fzf") }, -- finder

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = use("treesitter"),
  },
  "RRethy/nvim-treesitter-textsubjects", -- adds smart text objects
  "windwp/nvim-ts-autotag", -- automatically close jsx tags
  "HiPhish/nvim-ts-rainbow2",
  "JoosepAlviste/nvim-ts-context-commentstring", -- makes jsx comments actually work
  "aklt/plantuml-syntax",

  { "rebelot/kanagawa.nvim", config = use("theme") }, -- theme

  -- highlight color codes
  {
    "RRethy/vim-hexokinase",
    config = use("hexokinase"),
    build = "make hexokinase",
  },

  -- lang
  { "ray-x/go.nvim", config = use("go") },
  { "jose-elias-alvarez/typescript.nvim", config = use("ts") },
})
