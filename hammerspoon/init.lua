-- Map CTRL, pressed alone, as ESC --

ctrl_pressed = false
key_pressed = false

control_handler = function(evt)
  local flags = evt:getFlags()
  local key_code = evt:getKeyCode()

  if flags.ctrl and key_code == 62
    and not (flags.alt or flags.shift or flags.cmd or flags.fn)
  then
    ctrl_pressed = true
    key_pressed = false
  elseif ctrl_pressed
    and not (flags.cmd or flags.alt or flags.shift or flags.fn)
    and not key_pressed
  then
    ctrl_pressed = false
    return true, {
      hs.eventtap.event.newKeyEvent({}, 'escape', true),
      hs.eventtap.event.newKeyEvent({}, 'escape', false),
    }
  else
    key_pressed = true
  end
end

control_tap = hs.eventtap.new(
  {hs.eventtap.event.types.flagsChanged, hs.eventtap.event.types.keyUp},
  control_handler
)
control_tap:start()

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
