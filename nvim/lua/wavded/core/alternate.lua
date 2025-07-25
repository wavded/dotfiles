local handlers = {
  go = function(fname)
    if fname:match("_test.go$") then
      return fname:gsub("_test.go$", ".go")
    else
      return fname:gsub(".go$", "_test.go")
    end
  end,
  javascript = function(fname)
    if fname:match("_test.js$") then
      return fname:gsub("_test.js$", ".js")
    else
      return fname:gsub(".js$", "_test.js")
    end
  end,
  javascriptreact = function(fname)
    if fname:match("_test.jsx$") then
      return fname:gsub("_test.jsx$", ".jsx")
    else
      return fname:gsub(".jsx$", "_test.jsx")
    end
  end,
  typescript = function(fname)
    if fname:match("_test.ts$") then
      return fname:gsub("_test.ts$", ".ts")
    else
      return fname:gsub(".ts$", "_test.ts")
    end
  end,
  typescriptreact = function(fname)
    if fname:match("_test.tsx$") then
      return fname:gsub("_test.tsx$", ".tsx")
    else
      return fname:gsub(".tsx$", "_test.tsx")
    end
  end,
}

return function()
  local ft = vim.api.nvim_get_option_value("ft", {})
  local h = handlers[ft]

  if h ~= nil then
    local fname = h(vim.api.nvim_buf_get_name(0))

    local bufs = vim.api.nvim_tabpage_list_wins(0)

    for _, win in pairs(bufs) do
      local buf = vim.api.nvim_win_get_buf(win)
      local bufname = vim.api.nvim_buf_get_name(buf)

      if fname == bufname then
        vim.api.nvim_set_current_win(win)
        return
      end
    end

    vim.cmd("e " .. fname)
  end
end
