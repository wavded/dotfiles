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
        width = 80,
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
              padding = 2,
              align = "center",
              text = { greeting(), hl = "header" },
            },
            {
              icon = " ",
              key = "g",
              title = "Notifications",
              cmd = "gh notify -s -n5",
              action = ":lua vim.ui.open('https://github.com/notifications')",
              height = 4,
              section = "terminal",
              ttl = 10,
            },
            {
              icon = " ",
              key = "f",
              desc = "Find File",
              action = ":lua Snacks.dashboard.pick('files')",
            },
            {
              icon = " ",
              key = "n",
              desc = "New File",
              action = ":ene | startinsert",
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
            { section = "startup" },
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
            auto_close = true,
          },
        },
      },
      bigfile = {},
      explorer = {},
    },
    keys = {
      { "<space>f", "<cmd>lua Snacks.picker.smart()<cr>" },
      { "<space>b", "<cmd>lua Snacks.picker.buffers()<cr>" },
      { "<space>/", "<cmd>lua Snacks.picker.grep()<cr>" },
      { "<space>u", "<cmd>lua Snacks.picker.undo()<cr>" },
      { "<space>r", "<cmd>lua Snacks.picker.resume()<cr>" },
      { "<space>t", "<cmd>lua Snacks.explorer()<cr>" },
    },
  },
}
