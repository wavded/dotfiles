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
  "nvim-lua/plenary.nvim",

  "tpope/vim-sleuth", -- set tabwidth based on file type
  { "rebelot/kanagawa.nvim", config = use("theme") }, -- theme

  -- status line
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = use("lualine"),
  },
  "nvim-tree/nvim-web-devicons", -- support nerdfont icons

  {
    "echasnovski/mini.surround",
    event = "User FilePost",
    config = true,
  },

  -- motion
  {
    "smoka7/hop.nvim",
    event = "VeryLazy",
    config = use("hop"),
  },

  -- cursor word
  {
    "sontungexpt/stcursorword",
    event = "VeryLazy",
    config = true,
  },

  -- git gutter
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = true,
  },

  -- lsp
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = use("mason"),
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = "User FilePost",
    dependencies = {
      "b0o/schemastore.nvim", -- simple access to json-language-server schemae
      "nvimtools/none-ls.nvim", -- non lsp support
    },
  },

  -- completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    config = use("cmp"),
    dependencies = {
      -- close pairs and tags
      {
        {
          "windwp/nvim-autopairs",
          config = function()
            require("nvim-autopairs").setup()

            -- setup cmp for autopairs
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            require("cmp").event:on(
              "confirm_done",
              cmp_autopairs.on_confirm_done()
            )
          end,
        },
        "windwp/nvim-ts-autotag",
      },

      -- snippets
      {
        "dcampos/nvim-snippy",
        config = use("snippy"),
      },

      -- cmp extentions
      {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "dcampos/cmp-snippy",
        "lukas-reineke/cmp-rg",
      },
    },
  },

  -- global find / replace
  {
    "nvim-pack/nvim-spectre",
    cmd = { "Spectre" },
  },

  -- file tree
  {
    "nvim-tree/nvim-tree.lua",
    keys = { "<space>t" },
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    config = use("tree"),
    dependencies = {
      { "antosha417/nvim-lsp-file-operations" },
    },
  },

  { "ibhagwan/fzf-lua", config = use("fzf") }, -- finder

  -- highlight color codes
  {
    "NvChad/nvim-colorizer.lua",
    event = "VeryLazy",
    config = true,
  },

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    config = use("treesitter"),
    dependencies = {
      -- comments
      { "folke/ts-comments.nvim", config = true },

      -- rainbow delimiters
      "HiPhish/rainbow-delimiters.nvim",
    },
  },

  -- plantuml syntax - no treesitter support
  {
    "aklt/plantuml-syntax",
    ft = "plantuml",
  },

  -- lang
  {
    "ray-x/go.nvim",
    ft = "go",
    config = true,
  },
  -- {
  --   "pmizio/typescript-tools.nvim",
  --   config = true,
  -- },
})
