require("rexdiff")

rex.bind("ctrl+a>r", "client.config.reload")
rex.bind("ctrl+a>d", "rexdiff_toggle")

rex.bind("ctrl+a>ctrl+n", "client.tab.new")
rex.bind("ctrl+a>k", "client.tab.previous")
rex.bind("ctrl+a>ctrl+k", "client.tab.previous")
rex.bind("ctrl+a>j", "client.tab.next")
rex.bind("ctrl+a>ctrl+j", "client.tab.next")

rex.bind("ctrl+a>\\", "pane.split", { direction = "right" })
rex.bind("ctrl+a>-", "pane.split", { direction = "down" })
rex.bind("ctrl+a>enter", "pane.zoom")
rex.bind("ctrl+a>h", "pane.focus.left")
rex.bind("ctrl+a>l", "pane.focus.right")
rex.bind("ctrl+a>shift+h", "pane.resize", { direction = "left" })
rex.bind("ctrl+a>shift+j", "pane.resize", { direction = "down" })
rex.bind("ctrl+a>shift+k", "pane.resize", { direction = "up" })
rex.bind("ctrl+a>shift+l", "pane.resize", { direction = "right" })
rex.bind("ctrl+a>ctrl+a", "pane.send_key", { key = "ctrl+a" })

rex.action({
  name = "nvim",
  title = "nvim",
  run = function()
    local process, err =
      rex.block.call("com.superlogical.terminal", "process", {})
    assert(process, err)
    local size, err = rex.block.call("com.superlogical.terminal", "size", {})
    assert(size, err)
    local result, err = rex.session.new_layer({
      bounds = { 0, 0, 1, 1 },
      focus = true,
      layout = rex.layout.block({
        flavor = "com.superlogical.terminal.shell",
        options = {
          shell = "none",
          login = false,
          size = {
            columns = size.columns,
            rows = size.rows,
            cell_width_px = size.cell_width_px,
            cell_height_px = size.cell_height_px,
          },
          cwd = process.foreground and process.foreground.cwd or process.home,
          command = {
            "/bin/sh",
            "-c",
            'PATH="/opt/homebrew/bin:/usr/local/bin:$PATH" exec nvim',
          },
        },
      }),
    })
    assert(result, err)
    return result
  end,
})
rex.bind("ctrl+a>n", "nvim")
