return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "moon",
      on_colors = function(c)
        -- Match Rex's Abyssal Trench palette while keeping TokyoNight integrations.
        local palette = {
          bg = "#061421",
          bg_highlight = "#16202a",
          bg_visual = "#143349",
          bg_search = "#4a90c9",
          fg = "#b8cdd9",
          fg_dark = "#9db4c2",
          fg_gutter = "#0e1c29",
          comment = "#47606f",
          dark5 = "#47606f",
          terminal_black = "#0e1c29",
          border = "#25323d",
          blue = "#4a90c9",
          blue1 = "#6dabdd",
          blue2 = "#3fbdc9",
          blue5 = "#64d5df",
          blue6 = "#dcebf3",
          cyan = "#3fbdc9",
          green = "#52c79a",
          green1 = "#74dcb2",
          magenta = "#9179c9",
          magenta2 = "#ab95dc",
          orange = "#f18787",
          purple = "#ab95dc",
          red = "#e26a6a",
          red1 = "#e26a6a",
          teal = "#64d5df",
          yellow = "#d4b25e",
        }
        local light = vim.o.background == "light"
        if light then
          -- Match Rex's Merino Light palette.
          palette = {
            bg = "#ffffff",
            bg_highlight = "#f0f2f5",
            bg_visual = "#dceaff",
            bg_search = "#b6d8ff",
            fg = "#1f2328",
            fg_dark = "#57606a",
            fg_gutter = "#8c959f",
            comment = "#6e7781",
            dark5 = "#57606a",
            terminal_black = "#f0f2f5",
            border = "#d0d7de",
            blue = "#0969da",
            blue1 = "#218bff",
            blue2 = "#1b7c83",
            blue5 = "#3192aa",
            blue6 = "#57606a",
            cyan = "#1b7c83",
            green = "#116329",
            green1 = "#1a7f37",
            magenta = "#8250df",
            magenta2 = "#a475f9",
            orange = "#9d5c00",
            purple = "#8250df",
            red = "#cf222e",
            red1 = "#a40e26",
            teal = "#1b7c83",
            yellow = "#9d5c00",
          }
        end
        for name, color in pairs(palette) do
          c[name] = color
        end
        c.bg_dark = c.bg
        c.bg_dark1 = c.bg
        c.bg_popup = c.bg
        c.bg_statusline = c.bg
        c.bg_sidebar = c.bg
        c.bg_float = c.bg
        c.fg_sidebar = c.fg_dark
        c.fg_float = c.fg
        c.dark3 = c.fg_gutter
        c.black = c.bg
        c.border_highlight = c.blue
        c.blue0 = c.blue
        c.blue7 = c.bg_visual
        c.green2 = c.green1
        c.error = c.red
        c.warning = c.yellow
        c.info = c.blue
        c.hint = c.cyan
        c.todo = c.blue
        c.git =
          { add = c.green, change = c.blue, delete = c.red, ignore = c.dark3 }
        c.diff = light
            and {
              add = "#e5ede6",
              delete = "#fee9e7",
              change = "#e6effc",
              text = "#b6d8ff",
            }
          or {
            add = "#10292d",
            delete = "#251f27",
            change = "#0f2232",
            text = "#143349",
          }
        c.rainbow = {
          c.blue,
          c.yellow,
          c.green,
          c.teal,
          c.magenta,
          c.purple,
          c.orange,
          c.red,
        }
        c.terminal = light
            and {
              black = "#24292f",
              black_bright = "#57606a",
              red = c.red,
              red_bright = "#a40e26",
              green = c.green,
              green_bright = "#1a7f37",
              yellow = c.yellow,
              yellow_bright = "#c47a00",
              blue = c.blue,
              blue_bright = "#218bff",
              magenta = c.magenta,
              magenta_bright = "#a475f9",
              cyan = c.cyan,
              cyan_bright = "#3192aa",
              white = "#6e7781",
              white_bright = "#8c959f",
            }
          or {
            black = "#0e1c29",
            black_bright = "#47606f",
            red = c.red,
            red_bright = "#f18787",
            green = c.green,
            green_bright = "#74dcb2",
            yellow = c.yellow,
            yellow_bright = "#e6ca7f",
            blue = c.blue,
            blue_bright = "#6dabdd",
            magenta = c.magenta,
            magenta_bright = "#ab95dc",
            cyan = c.cyan,
            cyan_bright = "#64d5df",
            white = "#9db4c2",
            white_bright = "#dcebf3",
          }
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  {
    "echasnovski/mini.icons",
    lazy = true,
    opts = {},
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function(_, opts)
      local function set()
        local theme = require("lualine.themes._tokyonight").get()
        if vim.o.background == "light" then
          for _, mode in pairs(theme) do
            mode.b = { fg = "#1f2328", bg = "#f0f2f5" }
          end
        end
        opts.options.theme = theme
        require("lualine").setup(opts)
      end
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("wavded_lualine", { clear = true }),
        callback = set,
      })
      set()
    end,
    opts = { options = {} },
  },
}
