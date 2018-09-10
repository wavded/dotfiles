-- Map CTRL, pressed alone, as ESC --

send_escape = false
last_mods = {}

control_key_handler = function()
  send_escape = false
end

control_key_timer = hs.timer.delayed.new(0.15, control_key_handler)

control_handler = function(evt)
  local new_mods = evt:getFlags()
  if last_mods["ctrl"] == new_mods["ctrl"] then
    return false
  end
  if not last_mods["ctrl"] then
    last_mods = new_mods
    send_escape = true
    control_key_timer:start()
  else
    last_mods = new_mods
    control_key_timer:stop()
    if send_escape then
      return true, {
        hs.eventtap.event.newKeyEvent({}, 'escape', true),
        hs.eventtap.event.newKeyEvent({}, 'escape', false),
      }
    end
  end
  return false
end

control_tap = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, control_handler)
control_tap:start()

-- other_handler = function(evt)
--   send_escape = false
--   return false
-- end

-- other_tap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, other_handler)
-- other_tap:start()

-- Window Placement --

hs.window.animationDuration = 0
hs.hotkey.bind({"ctrl"}, "\\", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  local app = win:application()

  if app:name() == "iTerm2" then
    f.x = max.w - 600
    f.y = max.y
    f.w = 600
    f.h = max.h
  else
    f.x = max.x
    f.y = max.y
    f.w = max.w - 600
    f.h = max.h
  end

  win:setFrame(f)
end)
