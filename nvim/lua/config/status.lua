local function clock()
  return " " .. os.date("%H:%M")
end

local function lsp_progress(_, is_active)
  if not is_active then
    return ""
  end
  local messages = vim.lsp.util.get_progress_messages()
  if #messages == 0 then
    return ""
  end
  local status = {}
  for _, msg in pairs(messages) do
    table.insert(status, (msg.percentage or 0) .. "%% " .. (msg.title or ""))
  end
  local spinners = {
    "⠋",
    "⠙",
    "⠹",
    "⠸",
    "⠼",
    "⠴",
    "⠦",
    "⠧",
    "⠇",
    "⠏",
  }
  local ms = vim.loop.hrtime() / 1000000
  local frame = math.floor(ms / 120) % #spinners
  return table.concat(status, " | ") .. " " .. spinners[frame + 1]
end

vim.cmd([[autocmd User LspProgressUpdate let &ro = &ro]])

local config = {
  options = {
    section_separators = { left = "", right = "" },
    component_separators = { left = "|", right = "|" },
    icons_enabled = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = {
      { "diagnostics", sources = { "nvim_diagnostic" } },
      "filename",
    },
    lualine_x = { "filetype", lsp_progress },
    lualine_y = { "progress" },
    lualine_z = { clock },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  extensions = { "nvim-tree" },
}

-- try to load matching lualine theme

local M = {}

function M.load()
  local name = vim.g.colors_name or ""
  local ok, _ = pcall(require, "lualine.themes." .. name)
  if ok then
    config.options.theme = name
  end
  require("lualine").setup(config)
end

M.load()

return M
