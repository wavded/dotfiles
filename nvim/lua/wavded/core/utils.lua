local M = {}

M.info = {}

---Returns the Neovim version as formatted string.
---@return string
function M.info.nvim_version()
  local version = vim.version()
  local v = "v" .. version.major .. "." .. version.minor .. "." .. version.patch
  return v
end

---Returns the plugin stats.
---@return table
function M.info.plugin_stats()
  local stats = require("lazy").stats()
  local updates = require("lazy.manage.checker").updated
  return {
    count = stats.count,
    loaded = stats.loaded,
    startuptime = (math.floor(stats.startuptime * 100 + 0.5) / 100),
    updates = #updates,
  }
end

return M
