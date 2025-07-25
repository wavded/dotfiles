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
      keymap = {
        preset = "enter",
      },
      completion = {
        accept = {
          dot_repeat = true,
          auto_brackets = {
            enabled = true,
          },
        },
        list = {
          selection = {
            preselect = false,
            auto_insert = true,
          },
        },
        menu = {
          draw = {
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
      },
      signature = {
        enabled = true,
      },
      sources = {
        default = {
          "snippets",
          "copilot",
          "lazydev",
          "lsp",
          "path",
          "buffer",
        },
        providers = {
          snippets = {
            score_offset = 200,
          },
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            score_offset = 100,
            async = true,
          },
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        },
      },
    },
  },
}
