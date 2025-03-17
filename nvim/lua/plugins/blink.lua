return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
  {
    "saghen/blink.cmp",
    opts_extend = { "sources.default" },
    tag = "v0.12.2",
    version = "*",
    event = "InsertEnter",
    dependencies = {
      "fang2hou/blink-copilot",
      { "xzbdmw/colorful-menu.nvim", opts = {} },
    },
    opts = {
      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = "mono",
      },
      completion = {
        accept = {
          dot_repeat = false,
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
          draw = {
            -- treesitter = { "lsp" },
            columns = { { "kind_icon" }, { "label", gap = 1 } },
            components = {
              label = {
                text = function(ctx)
                  return require("colorful-menu").blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return require("colorful-menu").blink_components_highlight(
                    ctx
                  )
                end,
              },
            },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        ghost_text = {
          enabled = true,
        },
      },

      -- experimental signature help support
      signature = { enabled = true },

      sources = {
        default = { "copilot", "lsp", "path", "snippets", "buffer" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            score_offset = 100,
            async = true,
          },
        },
      },
    },
  },
}
