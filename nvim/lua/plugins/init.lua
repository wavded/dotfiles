vim.cmd("packadd packer.nvim")

return require("packer").startup(function(use)
  use({ "wbthomason/packer.nvim", opt = true })

  local config = function(name)
    return string.format("require('plugins.%s')", name)
  end

  local use_with_config = function(path, name)
    use({ path, config = config(name) })
  end

  use("tpope/vim-unimpaired") -- auto-pairs
  use("tpope/vim-repeat")
  use("tpope/vim-sleuth") -- set tabwidth based on file type
  use("tpope/vim-eunuch") -- unix commands (:SudoWrite)
  use_with_config("kylechui/nvim-surround", "surround")
  use_with_config("lewis6991/gitsigns.nvim", "gitsigns")

  -- text objects
  use({
    "kana/vim-textobj-user",
    {
      "kana/vim-textobj-entire", -- ae/ie for entire buffer
      "Julian/vim-textobj-variable-segment", -- av/iv for variable segment
      "michaeljsmith/vim-indent-object", -- ai/ii for indentation area
      "beloglazov/vim-textobj-punctuation", -- au/iu for punctuation
    },
  })

  use("ggandor/leap.nvim") -- motion
  use_with_config("echasnovski/mini.nvim", "mini") -- various modules
  use_with_config("nvim-lualine/lualine.nvim", "lualine") -- status line
  use_with_config("dcampos/nvim-snippy", "snippy") -- snippets
  use({
    "williamboman/mason.nvim", -- lsp installer
    requires = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = config("mason"),
  })
  use({
    "hrsh7th/nvim-cmp", -- completion
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "dcampos/cmp-snippy",
      "lukas-reineke/cmp-rg",
    },
    config = config("cmp"),
  })

  -- helpers
  use("nvim-lua/plenary.nvim")
  use("kyazdani42/nvim-web-devicons")

  use({ -- file tree
    "kyazdani42/nvim-tree.lua",
    tag = "nightly",
    config = config("tree"),
  })
  use_with_config("ibhagwan/fzf-lua", "fzf") -- finder

  -- lsp
  use("neovim/nvim-lspconfig") -- makes lsp configuration easier
  use("b0o/schemastore.nvim") -- simple access to json-language-server schemae
  use("jose-elias-alvarez/null-ls.nvim") -- non lsp support

  -- treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = config("treesitter"),
  })
  use("RRethy/nvim-treesitter-textsubjects") -- adds smart text objects
  use("windwp/nvim-ts-autotag") -- automatically close jsx tags
  use("p00f/nvim-ts-rainbow")
  use("JoosepAlviste/nvim-ts-context-commentstring") -- makes jsx comments actually work

  -- visual
  use({ "catppuccin/nvim", as = "catppuccin" }) -- theme
  use({
    "RRethy/vim-hexokinase", -- highlight color codes
    config = config("hexokinase"),
    run = "make hexokinase",
  })

  -- lang
  use_with_config("ray-x/go.nvim", "go")
end)
