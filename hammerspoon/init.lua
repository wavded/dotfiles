-- FYI: Local variables can be garbage collected, use globals if you want the state to always persist.

-- Map CTRL, pressed alone, as ESC --
can_escape = false

control_handler = function(evt)
  local flags = evt:getFlags()
  local key_code = evt:getKeyCode()
  -- print(flags, key_code, can_escape)

  -- Left control alone was pressed.
  if
    flags.ctrl
    and key_code == 62
    and not (flags.alt or flags.shift or flags.cmd or flags.fn)
  then
    can_escape = true

    -- Left control was pressed/released without any other key press in the middle.
  elseif
    can_escape
    and not (flags.ctrl or flags.cmd or flags.alt or flags.shift or flags.fn)
  then
    can_escape = false
    return true,
      {
        hs.eventtap.event.newKeyEvent({}, "escape", true),
        hs.eventtap.event.newKeyEvent({}, "escape", false),
      }

    -- Any key pressed.
  else
    can_escape = false
  end
end

control_tap = hs.eventtap.new(
  { hs.eventtap.event.types.flagsChanged, hs.eventtap.event.types.keyDown },
  control_handler
)
control_tap:start()

-- Window Placement --

hs.window.animationDuration = 0
hs.hotkey.bind({ "ctrl" }, "\\", function()
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
