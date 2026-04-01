return {
  {
    "folke/tokyonight.nvim",
    opts = function(_, opts)
      math.randomseed(os.time())
      local choose = function(choices)
        return choices[math.random(1, #choices)]
      end
      opts.lualine_bold = true
      opts.on_highlights = function(hl, c)
        hl["SnacksDashboardHeader"] = {
          fg = choose({
            c.blue,
            c.blue1,
            c.blue2,
            c.blue5,
            c.cyan,
            c.green,
            c.green2,
            c.magenta,
            c.orange,
            c.purple,
            c.red,
            c.teal,
            c.yellow,
          }),
        }
        hl["SnacksDashboardTitle"] = { fg = c.magenta, bold = true }
        hl["SnacksDashboardKey"] = { fg = c.orange, bold = true }
      end
      return opts
    end,
  },
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      dashboard = {
        width = 100,
        sections = function()
          local header = [[
      ████ ██████           █████      ██                    
     ███████████             █████                            
     █████████ ███████████████████ ███   ███████████  
    █████████  ███    █████████████ █████ ██████████████  
   █████████ ██████████ █████████ █████ █████ ████ █████  
 ███████████ ███    ███ █████████ █████ █████ ████ █████ 
██████  █████████████████████ ████ █████ █████ ████ ██████
]]
          local function greeting()
            local hour = tonumber(vim.fn.strftime("%H"))
            -- [02:00, 10:00) - morning, [10:00, 18:00) - day, [18:00, 02:00) - evening
            local part_id = math.floor((hour + 6) / 8) + 1
            local day_part = ({ "evening", "morning", "afternoon", "evening" })[part_id]
            local username = os.getenv("USER")
              or os.getenv("USERNAME")
              or "user"
            return ("Good %s, %s"):format(day_part, username)
          end

          return {
            { padding = 0, align = "center", text = { header, hl = "header" } },
            {
              padding = 1,
              align = "center",
              text = { greeting(), hl = "header" },
            },
            function()
              local version = require("wavded.core.utils").info.nvim_version()
              local plugin_stats =
                require("wavded.core.utils").info.plugin_stats()
              local date = os.date("%m.%d.%Y")
              local updates = plugin_stats.updates > 0
                  and "  " .. plugin_stats.updates .. ""
                or ""
              return {
                align = "center",
                text = {
                  { " ", hl = "footer" },
                  { version, hl = "Text" },
                  { "    ", hl = "footer" },
                  { tostring(plugin_stats.count), hl = "Text" },
                  { updates, hl = "special" },
                  { "   󰛕 ", hl = "footer" },
                  { plugin_stats.startuptime .. " ms", hl = "Text" },
                  { "    ", hl = "footer" },
                  { date, hl = "Text" },
                },
                padding = 1,
              }
            end,
            {
              icon = " ",
              key = "gn",
              title = "Notifications",
              cmd = "gh notify -sn4 && printf '\\n%.0s' {1..5}",
              action = ":lua vim.ui.open('https://github.com/notifications')",
              height = 5,
              section = "terminal",
              ttl = 0,
            },
            {
              icon = " ",
              key = "f",
              desc = "Find File",
              action = ":lua Snacks.dashboard.pick('smart')",
            },
            {
              icon = " ",
              key = "t",
              desc = "Explorer",
              action = ":lua Snacks.dashboard.pick('explorer')",
            },
            {
              icon = " ",
              key = "/",
              desc = "Grep",
              action = ":lua Snacks.dashboard.pick('grep')",
            },
            {
              icon = " ",
              key = "n",
              desc = "New File",
              action = ":ene | startinsert",
            },
            {
              icon = " ",
              key = "p",
              desc = "Prompt",
              action = ":CodeCompanion",
            },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            {
              icon = "󰒲 ",
              key = "l",
              desc = "Lazy",
              action = ":Lazy",
            },
            {
              icon = "󱁤 ",
              key = "m",
              desc = "Mason",
              action = ":Mason",
            },
            {
              icon = " ",
              key = "q",
              desc = "Quit",
              action = ":qa",
              padding = 1,
            },
          }
        end,
      },
      picker = {
        win = {
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "i", "n" } },
            },
          },
        },
        sources = {
          explorer = {
            layout = {
              preset = "default",
              preview = true,
            },
            auto_close = true,
          },
        },
      },
      notifier = {},
      indent = {
        indent = { char = "┊" },
        animate = { enabled = false },
        scope = { char = "┊" },
      },
      input = {},
      toggle = {},
      bigfile = {},
      explorer = {},
    },
    keys = {
      { "<leader>f", "<cmd>lua Snacks.picker.smart()<cr>" },
      { "<leader>b", "<cmd>lua Snacks.picker.buffers()<cr>" },
      { "<leader>/", "<cmd>lua Snacks.picker.grep()<cr>" },
      { "<leader>u", "<cmd>lua Snacks.picker.undo()<cr>" },
      { "<leader>r", "<cmd>lua Snacks.picker.resume()<cr>" },
      { "<leader>t", "<cmd>lua Snacks.explorer()<cr>" },
    },
  },
}
