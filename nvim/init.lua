vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0

local install_path = vim.fn.stdpath("data")
  .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap = nil

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
end

require("packer").startup(function(use)
  use("lewis6991/impatient.nvim") -- speed up load
  use("wbthomason/packer.nvim") -- package manager
  use("nvim-lua/plenary.nvim") -- async lua (for plugins)
  use({ -- hex colors
    "norcalli/nvim-colorizer.lua",
    ft = {
      "css",
      "scss",
      "sass",
      "javascriptreact",
      "typescriptreact",
      "lua",
    },
    config = function()
      require("colorizer").setup()
    end,
  })
  use({ "catppuccin/nvim", as = "catppuccin" }) -- theme

  use("JoosepAlviste/nvim-ts-context-commentstring") -- smart comment tracking
  use("tpope/vim-commentary") -- gcc and gc for comments
  use("tpope/vim-surround") -- text objects
  use("tpope/vim-repeat") -- repeat
  use("windwp/nvim-autopairs") -- auto pairs

  use("kyazdani42/nvim-web-devicons") -- dev icons
  use("kyazdani42/nvim-tree.lua") -- file explorer
  use("feline-nvim/feline.nvim") -- status line
  use("lewis6991/gitsigns.nvim") -- git sign column
  use("rhysd/git-messenger.vim") -- git commit messages

  use("nvim-telescope/telescope.nvim") -- go to file

  use({ -- tree sitter
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })
  use("p00f/nvim-ts-rainbow")
  use("aklt/plantuml-syntax") -- plantuml
  use("lepture/vim-jinja") -- jinja

  use("onsails/lspkind-nvim") -- lsp kind icons
  use("neovim/nvim-lspconfig") -- lsp configs
  use("williamboman/nvim-lsp-installer")
  use("nvim-lua/lsp-status.nvim") -- lsp status hooks
  use("folke/trouble.nvim") -- diagnostics
  use("ray-x/lsp_signature.nvim") -- fn signature
  use("ray-x/go.nvim") -- addn go support
  use("kosayoda/nvim-lightbulb") -- quick actions
  use("jose-elias-alvarez/null-ls.nvim") -- non lsp support

  use("hrsh7th/nvim-cmp") -- autocompletion (cmp)
  use("hrsh7th/cmp-nvim-lsp") -- cmp: LSP source
  use("hrsh7th/cmp-path") -- cmp: path source
  use("lukas-reineke/cmp-rg") -- cmp: ripgrep source
  use("dcampos/cmp-snippy") -- cmp: snippets source
  use("dcampos/nvim-snippy") -- snippets plugin

  if packer_bootstrap then
    require("packer").sync()
  end
end)

require("gitsigns").setup()

require("options")
require("keys")
require("theme")

require("config.lang")
require("config.lsp")
require("config.status")
require("config.treesitter")
require("config.finder")
require("config.tree")
require("config.snippets")
