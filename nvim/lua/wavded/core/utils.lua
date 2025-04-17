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

---Returns the lsp server status as formatted string.
---@return string
function M.info.lsp()
  local clients = vim.lsp.get_clients({ bufnr = 0 }) -- 0 = current buffer
  local count = #clients
  if count < 1 then
    return ""
  end
  return icons.lsp.server_active .. " " .. count
end

---Returns the LSP servers attached to the current buffer as formatted string.
---@return string?
function M.info.lsp_servers()
  -- bashls, clangd, cssls, jdtls, marksman, phpactor, pyright, vimls,
  -- yamlls, ts_ls, html, typos_lsp, jsonls, ruff_lsp, lua_ls, volar
  local clients = vim.lsp.get_clients({ bufnr = 0 }) -- 0 = current buffer

  local names = {}
  for _, client in pairs(clients) do
    table.insert(names, client.name)
  end
  return table.concat(names, ",")
end

---Returns the spell checking status as formatted string.
---@return string
function M.info.spell()
  if not vim.wo.spell then
    return ""
  end
  return icons.option.spell
end

---Returns spell languages as formatted string if spell checking is enabled.
---@return string
function M.info.spell_languages()
  if not vim.wo.spell then
    return ""
  end
  -- local languages = vim.o.spelllang
  local languages = table.concat(vim.opt.spelllang:get(), ",")
  return languages
end

---Returns true if we are in a Git repository otherwise false.
---@return boolean
function M.info.in_git_repo()
  -- local cwd = vim.uv.cwd()
  -- local cmd = 'cd "' .. cwd .. '"; git rev-parse --show-toplevel 2> /dev/null'
  local cmd = "git rev-parse --show-toplevel 2> /dev/null"
  local handle = io.popen(cmd)
  if handle == nil then
    return false
  end
  local result = handle:read("*a")
  handle:close()
  return result ~= ""
end

local proxy_active = nil
---Returns true if we are in a proxy environment otherwise false.
---@return boolean
function M.is_proxy_active()
  -- BUG: The `vim.fn.system` produces a cursor flickering with the lualine plugin!
  --      The command is executed with every lualine refresh.
  --
  -- Workaround: Check for proxy only once ( TODO: per nvim startup).
  if proxy_active ~= nil then
    return proxy_active
  end

  -- TODO: What is the difference between `vim.fn.system()` and `io.popen()`?
  --       What is better in this case?

  -- Variant 1: `vim.fn.system()`
  local result = vim.trim(vim.fn.system("echo $http_proxy"))
  proxy_active = result ~= ""

  -- Variant 2: `io.popen()`
  -- local cmd = 'echo $http_proxy'
  -- local handle = io.popen(cmd)
  -- if handle == nil then return false end
  -- local result = vim.trim(handle:read('*a'))
  -- handle:close()
  -- proxy_active = result ~= ''

  return proxy_active
end

M.toggle = {}

local diagnostics_visible = true
---Toggle diagnostics visibility for current buffer.
---@return nil
function M.toggle.diagnostics_visibility()
  if diagnostics_visible then
    vim.diagnostic.hide(nil, 0) -- current buffer
    -- vim.diagnostic.hide() -- all buffers
  else
    vim.diagnostic.show(nil, 0) -- current buffer
    -- vim.diagnostic.show() -- all buffers
  end
  diagnostics_visible = not diagnostics_visible
end

-- M.vim = {}
--
-- ---Sets special keymappings for prev/next.
-- ---@param mode string
-- ---@param rhs string
-- ---@param opts table
-- function M.vim.keymap_set_prev_next(mode, rhs, opts)
--   local mappings = { ['['] = 'ü', [']'] = { '+', 'ä' }, ['{'] = 'Ü', ['}'] = 'Ä' }
--   local starts_with = string.sub(rhs, 1, 1)
--   if mappings[starts_with] ~= nil then
--     local value = mappings[starts_with]
--     local mapping = type(value) == 'table' and value or { value }
--     for _, map in pairs(mapping) do
--       local lhs = string.gsub(rhs, '%' .. starts_with, map)
--       vim.keymap.set(mode, lhs, rhs, opts)
--     end
--   end
-- end

M.color = {}

---Limits a value between min and max.
---@param value number
---@param min number
---@param max number
---@return number
local function limit(value, min, max)
  return math.min(math.max(value, min), max)
end

---Limits a value between 0 and 255.
---@param value number
---@return number
local function limit_rgb(value)
  return limit(value, 0, 255)
end

---Limits a value between 0 and 100.
---@param value number
---@return number
local function limit_percent(value)
  return limit(value, 0, 100)
end

---Limits a value between 0 and 1.
---@param value number
---@return number
local function limit_alpha(value)
  return limit(value, 0, 1)
end

---Converts HSL values to RGB values.
-- https://www.w3.org/TR/css-color-3/#hsl-color
---@param h integer The hue value in degrees.
---@param s integer The saturation value in percent.
---@param l integer The lightness value in percent.
---@return integer, integer, integer
local function hsl_to_rgb(h, s, l)
  h, s, l = h % 360, s / 100, l / 100
  if h < 0 then
    h = h + 360
  end
  local function f(n)
    local k = (n + h / 30) % 12
    local a = s * math.min(l, 1 - l)
    return l - a * math.max(-1, math.min(k - 3, 9 - k, 1))
  end
  return f(0) * 255, f(8) * 255, f(4) * 255
end

---Converts HEX string to RGB values.
---@param hex string The hexadecimal value in the format #rrggbb.
---@return table # The RGB values in the format { r = integer, g = integer, b = integer }.
local function hex_to_rgb(hex)
  return {
    r = tonumber(hex:sub(2, 3), 16),
    g = tonumber(hex:sub(4, 5), 16),
    b = tonumber(hex:sub(6, 7), 16),
  }
end

---Converts the RGB values to a HEX string.
---@param r integer The red value.
---@param g integer The green value.
---@param b integer The blue value.
---@return string # The hexadecimal value in the format #rrggbb.
function M.color.rgb_to_hex(r, g, b)
  r, g, b = limit_rgb(r), limit_rgb(g), limit_rgb(b)
  return string.format("#%02x%02x%02x", r, g, b)
end

---Converts the RGBA values to a HEX string.
---@param r integer The red value.
---@param g integer The green value.
---@param b integer The blue value.
---@param a number The alpha value in the range 0-1.
---@return string # The hexadecimal value in the format #rrggbb.
function M.color.rgba_to_hex(r, g, b, a)
  r, g, b = limit_rgb(r), limit_rgb(g), limit_rgb(b)
  a = limit_alpha(a)
  return string.format("#%02x%02x%02x", r * a, g * a, b * a)
end

---Converts the HSL values to a HEX string.
---@param h integer The hue value in degrees.
---@param s integer The saturation value in percent.
---@param l integer The lightness value in percent.
---@return string # The hexadecimal value in the format #rrggbb.
function M.color.hsl_to_hex(h, s, l)
  s, l = limit_percent(s), limit_percent(l)
  local r, g, b = hsl_to_rgb(h, s, l)
  return string.format("#%02x%02x%02x", r, g, b)
end

---Converts the HSLA values to a HEX string.
---@param h integer The hue value in degrees.
---@param s integer The saturation value in percent.
---@param l integer The lightness value in percent.
---@param a number The alpha value in the range 0-1.
---@return string # The hexadecimal value in the format #rrggbb.
function M.color.hsla_to_hex(h, s, l, a)
  s, l = limit_percent(s), limit_percent(l)
  a = limit_alpha(a)
  local r, g, b = hsl_to_rgb(h, s, l)
  return string.format("#%02x%02x%02x", r * a, g * a, b * a)
end

---Converts CMYK values to a HEX string.
---@param c integer The cyan value in percent.
---@param m integer The magenta value in percent.
---@param y integer The yellow value in percent.
---@param k integer The black value in percent.
---@return string # The hexadecimal value in the format #rrggbb.
function M.color.cmyk_to_hex(c, m, y, k)
  c, m, y, k =
    limit_percent(c), limit_percent(m), limit_percent(y), limit_percent(k)
  c, m, y, k = c / 100, m / 100, y / 100, k / 100
  local r = 255 * (1 - c) * (1 - k)
  local g = 255 * (1 - m) * (1 - k)
  local b = 255 * (1 - y) * (1 - k)
  return string.format("#%02x%02x%02x", r, g, b)
end

---Mixes two HEX strings with a certain weighting.
---@param hex1 string The first hexadecimal value in the format #rrggbb.
---@param hex2 string The second hexadecimal value in the format #rrggbb.
---@param weight number The weight of the second color in the range 0-1.
---@return string # The hexadecimal value in the format #rrggbb.
function M.color.mix_hex_colors(hex1, hex2, weight)
  weight = limit_alpha(weight)
  local rgb1 = hex_to_rgb(hex1)
  local rgb2 = hex_to_rgb(hex2)
  local r = math.floor((rgb1.r * (1 - weight) + rgb2.r * weight) + 0.5)
  local g = math.floor((rgb1.g * (1 - weight) + rgb2.g * weight) + 0.5)
  local b = math.floor((rgb1.b * (1 - weight) + rgb2.b * weight) + 0.5)
  return M.color.rgb_to_hex(r, g, b)
end

M.bufferline = {}

---Returns bufferline highlights with own background colors.
---@param bg_default string|nil The default background color for the bufferline.
---@param bg_active string|nil The active background color for the selected buffers.
---@param bg_inactive string|nil The inactive background color for the non-selected buffers.
---@return table
function M.bufferline.background_highlights(bg_default, bg_active, bg_inactive)
  local fill_bg = bg_default
  local tab_bg = bg_inactive
  local tab_selected_bg = bg_active
  local buffer_bg = bg_inactive
  local buffer_visible_bg = bg_active
  local buffer_selected_bg = bg_active

  if bg_default == nil and bg_active == nil and bg_inactive == nil then
    return {}
  end

  return {
    -- Base highlights
    fill = { bg = fill_bg }, -- Bufferline background

    -- Tab highlights
    tab = { bg = tab_bg },
    tab_selected = { bg = tab_selected_bg },
    tab_separator = { fg = fill_bg, bg = tab_bg },
    tab_separator_selected = { fg = fill_bg, bg = tab_selected_bg },
    tab_close = { bg = fill_bg },

    -- Buffer highlights
    background = { bg = buffer_bg },

    buffer_visible = { bg = buffer_visible_bg },
    buffer_selected = { bg = buffer_selected_bg },

    close_button = { bg = buffer_bg },
    close_button_visible = { bg = buffer_visible_bg },
    close_button_selected = { bg = buffer_selected_bg },

    indicator_visible = { fg = fill_bg, bg = buffer_visible_bg },
    indicator_selected = { fg = fill_bg, bg = buffer_selected_bg }, -- BUG: Does not work with theme transparency in mode 'thin' for indicator icon!

    separator = { fg = fill_bg, bg = buffer_bg },
    separator_visible = { fg = fill_bg, bg = buffer_visible_bg },
    separator_selected = { fg = fill_bg, bg = buffer_selected_bg },

    modified = { bg = buffer_bg },
    modified_visible = { bg = buffer_visible_bg },
    modified_selected = { bg = buffer_selected_bg },

    duplicate = { bg = buffer_bg },
    duplicate_visible = { bg = buffer_visible_bg },
    duplicate_selected = { bg = buffer_selected_bg },

    diagnostic = { bg = buffer_bg },
    diagnostic_visible = { bg = buffer_visible_bg },
    diagnostic_selected = { bg = buffer_selected_bg },

    error = { bg = buffer_bg },
    error_visible = { bg = buffer_visible_bg },
    error_selected = { bg = buffer_selected_bg },
    warning = { bg = buffer_bg },
    warning_visible = { bg = buffer_visible_bg },
    warning_selected = { bg = buffer_selected_bg },
    info = { bg = buffer_bg },
    info_visible = { bg = buffer_visible_bg },
    info_selected = { bg = buffer_selected_bg },
    hint = { bg = buffer_bg },
    hint_visible = { bg = buffer_visible_bg },
    hint_selected = { bg = buffer_selected_bg },

    error_diagnostic = { bg = buffer_bg },
    error_diagnostic_visible = { bg = buffer_visible_bg },
    error_diagnostic_selected = { bg = buffer_selected_bg },
    warning_diagnostic = { bg = buffer_bg },
    warning_diagnostic_visible = { bg = buffer_visible_bg },
    warning_diagnostic_selected = { bg = buffer_selected_bg },
    info_diagnostic = { bg = buffer_bg },
    info_diagnostic_visible = { bg = buffer_visible_bg },
    info_diagnostic_selected = { bg = buffer_selected_bg },
    hint_diagnostic = { bg = buffer_bg },
    hint_diagnostic_visible = { bg = buffer_visible_bg },
    hint_diagnostic_selected = { bg = buffer_selected_bg },
  }
end

---Returns bufferline highlights with fixed colors
---for theme with activated transparent background.
---@param bg_default string|nil
---@param bg_inactive string|nil
---@return table
function M.bufferline.fixed_highlights(bg_default, bg_inactive)
  return M.bufferline.background_highlights(bg_default, nil, bg_inactive)
end

M.codeium = {}

---Returns Codeium status as formatted string.
---@return string
function M.codeium.status()
  if not pcall(vim.fn["codeium#Enabled"]) then
    return ""
  end
  if not vim.fn["codeium#Enabled"]() then
    return ""
  end
  local status = icons.codeium -- '󰘦'
  -- vim.api.nvim_call_function("codeium#GetStatusString", {})
  local str = string.gsub(vim.fn["codeium#GetStatusString"](), "%s+", "")
  if str ~= "ON" and str ~= "" then
    status = status .. " " .. str
  end
  return status
end

M.supermaven = {}

---Returns Supermaven status as formatted string.
---@return string
function M.supermaven.status()
  if not pcall(require("supermaven-nvim.api").is_running) then
    return ""
  end
  if not require("supermaven-nvim.api").is_running() then
    return ""
  end -- 󱙻
  local status = icons.supermaven or "󱙺"

  -- FIX: Workaround for connection timeout behind a proxy
  --
  if M.is_proxy_active() == true then
    status = icons.supermaven_error or "󱙻"
  end

  return status
end

return M
