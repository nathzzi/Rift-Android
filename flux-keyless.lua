
if FLUX_ID == "db4701c676797797d49f327174873408cab79da46a315b72d3643cb830e050fe4b9f779e7750389d26da5a5156f9a36d" 
or FLUX_ID == "48bceadda325229ddf4750817d2334dd0908f4a0557e89f08aef2559f4d99d9cbd7312886770246fd57012aaf48c3a50" 
or string.find(FLUX_ID, "punkteam")
then
    getgenv().FLUX_ID = "cracked";
    
--game:GetService("Players").LocalPlayer:Kick("Using keyless / cracked versions / Punk Team Versions of Fluxus will get you banned from using Fluxus. Only use official releases of Fluxus.");
end

if BUILD_ID == nil then
    
    game:GetService("Players").LocalPlayer:Kick("Please update Fluxus");
    
    return;
end



local res, error = pcall(function()
    getgenv().firesignal = newcclosure(function(signal, ...)
        assert(signal, "i want signal");
        for i,v in pairs(getconnections(signal)) do
            v.Function(...)
        end
    end)
    
    local coregui = game:GetService("CoreGui");
    local corepack = game:GetService("CorePackages");

    function let_pass(v)
        if v.Parent ~= nil then
            if v.Parent ==  coregui or v.Parent == corepack then
                if v.Parent.Parent then
                    local ol;
                    ol = v.Parent.Parent;
      
                    while ol do
                        if ol == coregui or ol == corepack then
                            return false			
                        end
        
                        if ol.Parent ~= nil then
                            ol = ol.Parent
                        end
                    end
                end
    
                return false
            end
        end

        return true
    end

    getgenv().getloadedmodules = newcclosure(function()
        local modules = {}
        for i,v in pairs(getscripts()) do
            if v:IsA("ModuleScript") and let_pass(v) then
                table.insert(modules, v)
            end
        end

        return modules
    end)

    getgenv().hookmetamethod = function(obj, method, func)
      if func == nil or typeof(func) ~= "function" then
        return error("invalid argument #3 to 'hookmetamethod'")
      end
    
      --if isnewcclosure(func) and not isnewcclosure(func, true) then
      --  set_discount_hookfunction(func, true, method)
      --end
    
      func = islclosure(func) and newcclosure(func) or func
    
      OriginalFunction = hookfunction(getrawmetatable(obj)[method], func)
    
      return OriginalFunction
    end
          
    spawn(function()
        if teleport_handle_hideenv then
            local teleport_handle = teleport_handle_hideenv
            
            repeat wait() until game:GetService("Players").LocalPlayer
            
            game:GetService("Players").LocalPlayer.OnTeleport:connect(function(teleportState)
                teleport_handle()
            end)
            getgenv().teleport_handle_hideenv = nil
        end
    end)
          
          local old_require = getrenv().require
          local setidentity = set_thread_context

          local VirtualInputManager = Instance.new("VirtualInputManager")
          local GuiService = game:GetService("GuiService")

          local VirtualInput = {}
          local currentWindow = nil

          function VirtualInput.setCurrentWindow(window)
              local old = currentWindow
              currentWindow = window
              return old
          end

          local function handleGuiInset(x, y)
              local guiOffset, _ = GuiService:GetGuiInset()
              return x + guiOffset.X, y + guiOffset.Y
          end

          function VirtualInput.sendMouseButtonEvent(x, y, button, isDown)
              x, y = handleGuiInset(x, y)
              VirtualInputManager:SendMouseButtonEvent(x, y, button, isDown, currentWindow, 0)
          end

          function VirtualInput.SendKeyEvent(isPressed, keyCode, isRepeated)
              VirtualInputManager:SendKeyEvent(isPressed, keyCode, isRepeated, currentWindow)
          end

          function VirtualInput.SendMouseMoveEvent(x, y)
              x, y = handleGuiInset(x, y)
              VirtualInputManager:SendMouseMoveEvent(x, y, currentWindow)
          end

          function VirtualInput.sendTextInputCharacterEvent(str)
              VirtualInputManager:sendTextInputCharacterEvent(str, currentWindow)
          end

          function VirtualInput.SendMouseWheelEvent(x, y, isForwardScroll)
              x, y = handleGuiInset(x, y)
              VirtualInputManager:SendMouseWheelEvent(x, y, isForwardScroll, currentWindow)
          end

          function VirtualInput.SendTouchEvent(touchId, state, x, y)
              x, y = handleGuiInset(x, y)
              VirtualInputManager:SendTouchEvent(touchId, state, x, y)
          end

          function VirtualInput.mouseWheel(vec2, num)
              local forward = false
              if num < 0 then
                  forward = true
                  num = -num
              end
              for _ = 1, num do
                  VirtualInput.SendMouseWheelEvent(vec2.x, vec2.y, forward)
              end
          end

          function VirtualInput.touchStart(vec2)
              VirtualInput.SendTouchEvent(defaultTouchId, 0, vec2.x, vec2.y)
          end

          function VirtualInput.touchMove(vec2)
              VirtualInput.SendTouchEvent(defaultTouchId, 1, vec2.x, vec2.y)
          end

          function VirtualInput.touchStop(vec2)
              VirtualInput.SendTouchEvent(defaultTouchId, 2, vec2.x, vec2.y)
          end

          local function smoothSwipe(posFrom, posTo, duration)
              local passed = 0
              local started = false
              return function(dt)
                  if not started then
                      VirtualInput.touchStart(posFrom)
                      started = true
                  else
                      passed = passed + dt
                      if duration and passed < duration then
                          local percent = passed / duration
                          local pos = (posTo - posFrom) * percent + posFrom
                          VirtualInput.touchMove(pos)
                      else
                          VirtualInput.touchMove(posTo)
                          VirtualInput.touchStop(posTo)
                          return true
                      end
                  end
                  return false
              end
          end

          function VirtualInput.swipe(posFrom, posTo, duration, async)
              if async == true then
                  asyncRun(smoothSwipe(posFrom, posTo, duration))
              else
                  syncRun(smoothSwipe(posFrom, posTo, duration))
              end
          end

          function VirtualInput.tap(vec2)
              VirtualInput.touchStart(vec2)
              VirtualInput.touchStop(vec2)
          end

          function VirtualInput.click(vec2)
              VirtualInput.sendMouseButtonEvent(vec2.x, vec2.y, 0, true)
              VirtualInput.sendMouseButtonEvent(vec2.x, vec2.y, 0, false)
          end

          function VirtualInput.rightClick(vec2)
              VirtualInput.sendMouseButtonEvent(vec2.x, vec2.y, 1, true)
              VirtualInput.sendMouseButtonEvent(vec2.x, vec2.y, 1, false)
          end

          function VirtualInput.mouseLeftDown(vec2)
              VirtualInput.sendMouseButtonEvent(vec2.x, vec2.y, 0, true)
          end

          function VirtualInput.mouseLeftUp(vec2)
              VirtualInput.sendMouseButtonEvent(vec2.x, vec2.y, 0, false)
          end

          function VirtualInput.mouseRightDown(vec2)
              VirtualInput.sendMouseButtonEvent(vec2.x, vec2.y, 1, true)
          end

          function VirtualInput.mouseRightUp(vec2)
              VirtualInput.sendMouseButtonEvent(vec2.x, vec2.y, 1, false)
          end

          function VirtualInput.pressKey(keyCode)
              VirtualInput.SendKeyEvent(true, keyCode, false)
          end

          function VirtualInput.releaseKey(keyCode)
              VirtualInput.SendKeyEvent(false, keyCode, false)
          end

          function VirtualInput.hitKey(keyCode)
              VirtualInput.pressKey(keyCode)
              VirtualInput.releaseKey(keyCode)
          end

          function VirtualInput.mouseMove(vec2)
              VirtualInput.SendMouseMoveEvent(vec2.X, vec2.Y)
          end

          function VirtualInput.sendText(str)
              VirtualInput.sendTextInputCharacterEvent(str)
          end

          function nametoenum(name)
              return Enum.KeyCode[name] 
          end

          local KeyCodes = 
          {
              [0x08] = nametoenum("Backspace");
              [0x09] = nametoenum("Tab");
              [0x0C] = nametoenum("Clear");
              [0x0D] = nametoenum("Return");
              [0x10] = nametoenum("LeftShift");
              [0x11] = nametoenum("LeftControl");
              [0x12] = nametoenum("LeftAlt");
              [0xA5] = nametoenum("RightAlt");
              [0x13] = nametoenum("Pause");
              [0x14] = nametoenum("CapsLock");
              [0x1B] = nametoenum("Escape");
              [0x20] = nametoenum("Space");
              [0x21] = nametoenum("PageUp");
              [0x22] = nametoenum("PageDown");
              [0x23] = nametoenum("End");
              [0x24] = nametoenum("Home");
              [0x25] = nametoenum("Left");
              [0x26] = nametoenum("Up");
              [0x27] = nametoenum("Right");
              [0x28] = nametoenum("Down");
              [0x2A] = nametoenum("Print");
              [0x2D] = nametoenum("Insert");
              [0x2E] = nametoenum("Delete");
              [0x2F] = nametoenum("Help");
              [0x30] = nametoenum("Zero");
              [0x31] = nametoenum("One");
              [0x32] = nametoenum("Two");
              [0x33] = nametoenum("Three");
              [0x34] = nametoenum("Four");
              [0x35] = nametoenum("Five");
              [0x36] = nametoenum("Six");
              [0x37] = nametoenum("Seven");
              [0x38] = nametoenum("Eight");
              [0x39] = nametoenum("Nine");
              [0x41] = nametoenum("A");
              [0x42] = nametoenum("B");
              [0x43] = nametoenum("C");
              [0x44] = nametoenum("D");
              [0x45] = nametoenum("E");
              [0x46] = nametoenum("F");
              [0x47] = nametoenum("G");
              [0x48] = nametoenum("H");
              [0x49] = nametoenum("I");
              [0x4A] = nametoenum("J");
              [0x4B] = nametoenum("K");
              [0x4C] = nametoenum("L");
              [0x4D] = nametoenum("M");
              [0x4E] = nametoenum("N");
              [0x4F] = nametoenum("O");
              [0x50] = nametoenum("P");
              [0x51] = nametoenum("Q");
              [0x52] = nametoenum("R");
              [0x53] = nametoenum("S");
              [0x54] = nametoenum("T");
              [0x55] = nametoenum("U");
              [0x56] = nametoenum("V");
              [0x57] = nametoenum("W");
              [0x58] = nametoenum("X");
              [0x59] = nametoenum("Y");
              [0x5A] = nametoenum("Z");
              [0x5B] = nametoenum("LeftSuper");
              [0x5C] = nametoenum("RightSuper");
              [0x60] = nametoenum("KeypadZero");
              [0x61] = nametoenum("KeypadOne");
              [0x62] = nametoenum("KeypadTwo");
              [0x63] = nametoenum("KeypadThree");
              [0x64] = nametoenum("KeypadFour");
              [0x65] = nametoenum("KeypadFive");
              [0x66] = nametoenum("KeypadSix");
              [0x67] = nametoenum("KeypadSeven");
              [0x68] = nametoenum("KeypadEight");
              [0x69] = nametoenum("KeypadNine");
              [0x6A] = nametoenum("Asterisk");
              [0x6B] = nametoenum("Plus");
              [0x6D] = nametoenum("Minus");
              [0x6E] = nametoenum("Period");
              [0x6F] = nametoenum("Slash");
              [0x70] = nametoenum("F1");
              [0x71] = nametoenum("F2");
              [0x72] = nametoenum("F3");
              [0x73] = nametoenum("F4");
              [0x74] = nametoenum("F5");
              [0x75] = nametoenum("F6");
              [0x76] = nametoenum("F7");
              [0x77] = nametoenum("F8");
              [0x78] = nametoenum("F9");
              [0x79] = nametoenum("F10");
              [0x7A] = nametoenum("F11");
              [0x7B] = nametoenum("F12");
              [0x7C] = nametoenum("F13");
              [0x7D] = nametoenum("F14");
              [0x7E] = nametoenum("F15");
              [0x90] = nametoenum("NumLock");
              [0x91] = nametoenum("ScrollLock");
              [0xA0] = nametoenum("LeftShift");
              [0xA1] = nametoenum("RightShift");
              [0xA2] = nametoenum("LeftControl");
              [0xA3] = nametoenum("RightControl");
              [0xFE] = nametoenum("Clear");
              [0xBB] = nametoenum("Equals");
              [0xDB] = nametoenum("LeftBracket");
              [0xDD] = nametoenum("RightBracket");
          }

          function get_keycode(key)
              local x = KeyCodes[key]

              if x then
                  return x
              end

              return Enum.KeyCode.Unknown
          end

          getgenv().isrbxactive = function()
              return true
          end

          getgenv().iswindowactive = isrbxactive
          getgenv().isgameactive = isrbxactive

          getgenv().keypress = newcclosure(function(keyCode)
              if (typeof(keyCode) == "string") then
                  VirtualInput.pressKey(get_keycode(tonumber(keyCode)))
              elseif (typeof(keyCode) == "number") then
                  VirtualInput.pressKey(get_keycode(keyCode))
              else
                  VirtualInput.pressKey(keyCode)
              end
          end)

          getgenv().keyrelease = newcclosure(function(keyCode)
              if (typeof(keyCode) == "string") then
                  VirtualInput.releaseKey(get_keycode(tonumber(keyCode)))
              elseif (typeof(keyCode) == "number") then
                  VirtualInput.releaseKey(get_keycode(keyCode))
              else
                  VirtualInput.releaseKey(keyCode)
              end
          end)

          getgenv().mouse1click = newcclosure(function()
              VirtualInput.click(Vector2.new(game.Players.LocalPlayer:GetMouse().X, game.Players.LocalPlayer:GetMouse().Y))
          end)

          getgenv().mouse1press = newcclosure(function()
              VirtualInput.sendMouseButtonEvent(game.Players.LocalPlayer:GetMouse().X, game.Players.LocalPlayer:GetMouse().Y, 0, true)
          end)

          getgenv().mouse1release = newcclosure(function()
              VirtualInput.sendMouseButtonEvent(game.Players.LocalPlayer:GetMouse().X, game.Players.LocalPlayer:GetMouse().Y, 0, false)
          end)

          getgenv().mouse2press = newcclosure(function()
              VirtualInput.sendMouseButtonEvent(game.Players.LocalPlayer:GetMouse().X, game.Players.LocalPlayer:GetMouse().Y, 1, true)
          end)

          getgenv().mouse2release = newcclosure(function()
              VirtualInput.sendMouseButtonEvent(game.Players.LocalPlayer:GetMouse().X, game.Players.LocalPlayer:GetMouse().Y, 1, false)
          end)

          getgenv().mouse2click = newcclosure(function()
              VirtualInput.rightClick(Vector2.new(game.Players.LocalPlayer:GetMouse().X, game.Players.LocalPlayer:GetMouse().Y))
          end)

          getgenv().mousescroll = newcclosure(function(scroll)
              VirtualInput.mouseWheel(scroll, 1)
          end)

          getgenv().mousemoverel = newcclosure(function(x, y)
              VirtualInput.mouseMove(Vector2.new(x, y))
          end)

          getgenv().mousemoveabs = newcclosure(function(x, y)
              VirtualInput.mouseMove(Vector2.new(x, y))
          end)

          function left_click(x)
              if type(x) ~= "number" then
                  error("Bad argument (#1) to Input.LeftClick, expected number");
              end

              if(x == 1) then
                  mouse1release()
              elseif(x == 2) then
                  mouse1press()
              elseif(x == 3) then
                  mouse1click()
              end
          end

          function right_click(x)
              if type(x) ~= "number" then
                  error("Bad argument (#1) to Input.RightClick, expected number");
              end

              if(x == 1) then
                  mouse2release()
              elseif(x == 2) then
                  mouse2press()
              elseif(x == 3) then
                  mouse2click()
              end
          end

    function key_press(x)
        if type(x) ~= "number" then
            error("Bad argument (#1) to Input.KeyPress, expected number");
        end

        keypress(x)
        keyrelease(x);
    end

    getgenv().Input = {
        LeftClick = left_click;
        RightClick = right_click;
        KeyPress = key_press;
        KeyDown = keypress;
        KeyUp = keyrelease;
    }

    setreadonly(Input, true)

    getgenv().require = function(script)
      local old_identity = setidentity(2)
      local success, err = pcall(old_require, script)
      setidentity(old_identity)
      assert(success, err)
  
      return err
    end
         
    finishinject_hideenv();
    getgenv().finishinject_hideenv = nil;
end)

if res == false then
    warn("err", error);
end


pcall(function()

if Drawing then
    return;
end



local function Random(length)
    local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
    local result = ""
    for i = 1, length do
        local randomIndex = math.random(1, #chars)
        result = result .. chars:sub(randomIndex, randomIndex)
    end
    return result
end


Parent = Instance.new("ScreenGui")
Parent.Parent = gethui()
Parent.Name = Random(math.random(10, 15))
Parent.IgnoreGuiInset = true

local a = math.floor
local b = { Visible = true, Transparency = true, Color = true, Thickness = true }
local c = { PointA = true, PointB = true, PointC = true, PointD = true, A = 1, B = 2, C = 3, D = 4 }

local function e()
    local f = { CreateInc("Line"), CreateInc("Line"), CreateInc("Line"), CreateInc("Line") }
    local g
    g = setmetatable({
        Remove = function(self)
            setmetatable(g, {})
            self.Remove = nil
            for h = 1, 4 do f[h]:Remove() end
        end
    }, {
        __newindex = function(self, i, j)
            if b[i] then
                for h = 1, 4 do f[h][i] = j end
                return
            end
            local k = c[i]
            if k then
                k = c[tostring(i):sub(-1)]
                f[k].From = j
                f[k + 1 - a(k / 4) * 4].To = j
            end
        end
    })
    return g
end

local function l(m, n, o)
    local p = 2
    n = n and UDim2.new(0, n.X, 0, n.Y) or UDim2.new(0, 0, 0, 0)
    m = m and UDim2.new(0, m.X, 0, m.Y) or UDim2.new(0, 0, 0, 0)
    local q, r = n.X.Offset - m.X.Offset, n.Y.Offset - m.Y.Offset
    local h = (q * q + r * r) ^ 0.5
    local s = math.atan2(r, q)
    o.Size = UDim2.new(0, h, 0, p)
    local t, u = 0.5 * (m.X.Offset + n.X.Offset), 0.5 * (m.Y.Offset + n.Y.Offset)
    o.Position = UDim2.new(0, t - 0.5 * h, 0, u - 0.5 * p)
    o.Rotation = math.deg(s)
    o.BorderSizePixel = 0
    return o
end

getgenv().Drawing = {}
Drawing.Fonts = { UI = 0, System = 1, Plex = 2, Monospace = 3 }

getgenv().getrenderproperty = newcclosure(function(self, x)
  if x == "Remove" or x == "Destroy" then z:Destroy() return function() end end
  return w[x]
end)

getgenv().setrenderproperty = newclosure(function(self, x, y)
  w[x] = y
  if x == "Visible" then z.Visible = y end
  if x == "Color" then z.BackgroundColor3 = y end
  if x == "Transparency" then z.BackgroundTransparency = math.clamp(1 - y, 0, 1) end
  if x == "From" or x == "To" then d = l(w.From, w.To, z) end
end)

Drawing.new = newcclosure(function(v)
    if v == "Triangle" then
        local w = {}
        return setmetatable({}, {
            __index = getrenderproperty,
            __newindex = setrenderproperty
        })
    end

    if v == "Line" then
        local w = {}
        local z = Instance.new("Frame", Parent)
        z.ZIndex = 3000
        return setmetatable({}, {
            __index = function(self, x)
                if x == "Remove" or x == "Destroy" then z:Destroy() return function() end end
                return w[x]
            end,
            __newindex = function(self, x, y)
                w[x] = y
                if x == "Visible" then z.Visible = y end
                if x == "Color" then z.BackgroundColor3 = y end
                if x == "Transparency" then z.BackgroundTransparency = math.clamp(1 - y, 0, 1) end
                if x == "From" or x == "To" then d = l(w.From, w.To, z) end
            end
        })
    end

    if v == "Circle" then
        local A = {}
        local B = Instance.new("Frame", Parent)
        B.BorderSizePixel = 0
        B.AnchorPoint = Vector2.new(0.5, 0.5)
        Instance.new("UICorner", B).CornerRadius = UDim.new(1, 0)
        return setmetatable({}, {
            __index = function(self, x)
                if x == "Remove" or x == "Destroy" then return function() B:Destroy() end end
                return A[x]
            end,
            __newindex = function(self, x, y)
                A[x] = y
                if x == "Visible" then B.Visible = y end
                if x == "Transparency" then B.BackgroundTransparency = 1 - y end
                if x == "Color" then B.BackgroundColor3 = y end
                if x == "Position" then B.Position = UDim2.new(0, y.X, 0, y.Y) end
                if x == "Radius" then B.Size = UDim2.new(0, y * 2, 0, y * 2) end
            end
        })
    end

    if v == "Text" then
        local C = {}
        local D = Instance.new("TextLabel", Parent)
        D.BorderSizePixel = 0
        D.AnchorPoint = Vector2.new(0.5, 0.5)
        return setmetatable({}, {
            __index = function(self, x)
                if x == "Remove" or x == "Destroy" then return function() D:Destroy() end end
                return C[x]
            end,
            __newindex = function(self, x, y)
                C[x] = y
                if x == "Visible" then D.Visible = y end
                if x == "Color" then D.TextColor3 = y end
                if x == "Position" then D.Position = UDim2.new(0, y.X, 0, y.Y) end
                if x == "Transparency" then D.TextTransparency = math.clamp(1 - y, 0, 1) end
                if x == "Size" then D.TextSize = y - 10 end
                if x == "Text" then D.Text = y end
            end
        })
    end

    if v == "Quad" then return e() end

    if v == "Square" then
        local E = {}
        local F = Instance.new("Frame", Parent)
        F.BorderSizePixel = 0
        return setmetatable({}, {
            __index = function(self, x)
                if x == "Remove" or x == "Destroy" then return function() F:Destroy() end end
                return E[x]
            end,
            __newindex = function(self, x, y)
                E[x] = y
                if x == "Visible" then E.Visible = true; F.Visible = y end
                if x == "Color" then F.BackgroundColor3 = y end
                if x == "Transparency" then F.BackgroundTransparency = math.clamp(1 - y, 0, 1) end
                if x == "Position" then F.Position = UDim2.new(0, y.X, 0, y.Y) end
                if x == "Size" then F.Size = UDim2.new(0, y.X, 0, y.Y) end
            end
        })
    end
end)

end)

local name = identifyexecutor();

if name == "Delta" then


    
    --wait(1);
    --loadstring(game:HttpGet("https://raw.githubusercontent.com/lxnnydev/DeltaAndroid/main/keysys.lua"))()
    
    --return;
elseif name == "Codex" then


    
    wait(1);
    
    --loadstring(game:HttpGetAsync("https://cdn.codex.lol/public/main.txt"))();

    return;
end

--FLUXUS_CORAL = true;

if FLUXUS_CORAL then

loadstring(game:HttpGetAsync("https://flux.li/android/external/coral_ui.txt"))();

return;

end


-- Built at Sun Mar 12 2023 19:14:47 GMT-0400 (Eastern Daylight Time) in Production Mode
return (function() -- put everything in a seperate closure
-- Fluxus Android Init Script
-- Copyright (c) 2022 YieldingExploiter. All Rights Reserved.
-- Copyright (c) 2022 ShowerHeadFD. All Rights Reserved.

local null = nil -- null is better than nil, change my mind
local modules = {} -- we will assign modules to here later
local require = function(...) -- handle loading modules
  local requested, returned = { ... }, {}
  for _, filepath in pairs(requested) do
    if not modules[filepath] then
      error('[flux bundler] no such module \'' .. filepath .. '\'')
    end
    local module = modules[filepath]
    if module.isCached then
      table.insert(returned, module.cache)
    else
      local moduleValue = module.load()
      module.cache = moduleValue
      module.isCached = true
      table.insert(returned, module.cache)
    end
  end
  return table.unpack(returned)
end

local authvf = AeVPjNWXqQ or function()
  return true
end
getgenv().AeVPjNWXqQ = nil

local rawGetScripts = getscripts_hideenv or function()
  return -1
end
local scriptList = rawGetScripts()
getgenv().getscripts_hideenv = nil
local getscripts = function()
  if not scriptList then
    scriptList = rawGetScripts()
  end
  return scriptList
end
local setpurchaseprotections = setpurchaseprotections_hideenv or function(b) end
getgenv().setpurchaseprotections_hideenv = nil

--> BEGIN Initial Module Definitions <--

modules['asset-obj.lua'] = {};
modules['asset-obj.lua'].load = function()
local list = {
  ['rbxassetid://11447435879'] = 'minimize_btn';
  ['rbxassetid://11447575636'] = 'desc';
  ['rbxassetid://11434416211'] = 'icon';
  ['rbxassetid://11445282332'] = 'icon-2';
  ['rbxassetid://11447558233'] = 'settings';
  ['rbxassetid://11706698017'] = 'hist-icon';
  ['rbxassetid://11810985691'] = 'scriptbeans';
  ['rbxassetid://11440677815'] = 'welcome-banner-easteregg';
  ['rbxassetid://11445329779'] = 'credits-banner-easteregg';
  ['rbxassetid://11706521913'] = 'history-banner-easteregg';
  ['rbxassetid://11441550965'] = 'scripts-banner-easteregg';
  ['rbxassetid://11441550965'] = 'scripts-banner-easteregg';
  ['rbxassetid://11441541927'] = 'settings-banner-easteregg';
};

return setmetatable({},{
  __index = function(t,k)
      return k
  end;
});

end;
modules['asset-obj.lua'].cache = null;
modules['asset-obj.lua'].isCached = false;

----

modules['index.lua'] = {};
modules['index.lua'].load = function()
local isDebug = isfile '.debugLOGGGG'
local debug = function() end
if isDebug then
  debug = function(...)
    print('debug:', ...)
  end
  local oldreq = require
  require = function(...)
    print('debug: require():', ...)
    return oldreq(...)
  end
end
-- load lua patches
debug 'loadpatch'
require 'patches/LoadCfgLib'
require 'patches/PatchUnavailableDecompiler'
require 'patches/PatchReadClipboard'
require 'patches/PatchAuthReads'
require 'patches/PatchAuthListfiles'
require 'patches/PolyfillRConsole'
require 'patches/HookSetfpscap'
-- quick init ui
debug 'createui'
local ui = require 'lib/ui'
ui.CreateUI()
-- load shit
debug 'loadauth'
local auth = require 'auth'
-- check for authentication
debug 'tryauth'
local IsSuccessfulAuth = auth.TryAuthenticate()
local DoCustomInit = function()
  -- if init file, call init file instead of loading the actual ui | this happens post-auth so it should be fine from a security pov
  debug 'custinit'
  if (isfile 'fVV282L8Z.dev' or isfile 'fVV282L8Z.lua') and not isDev then
    getgenv().readclipboard_hideenv = require 'patches/PatchReadClipboard'
    ui.UI.Enabled = false -- hide ui
    loadstring(readfile(isfile 'fVV282L8Z.dev' and 'fVV282L8Z.dev' or isfile 'fVV282L8Z.lua' and 'fVV282L8Z.lua'))() -- load init
    return true
  else
    return false
  end
end
-- define func for init main ui
debug 'completeuidef'
local CompleteUI
CompleteUI = function()
  debug 'completeui'
  -- dont allow double init
  CompleteUI = function() end
  -- allow custom init shit
  if runautoexec_hideenv then
    runautoexec_hideenv()
    getgenv().runautoexec_hideenv = nil
  end

  if DoCustomInit() then
    return true
  end
  ui.SetUnminimizeTarget 'MainUI'
  -- create tabs
  require 'lib/ui/CreateBaseUI'()
  require 'lib/ui/CreateScriptsUI'()
  require 'lib/ui/CreateScriptBloxUI'()
  require 'lib/ui/CreateSettingsUI'()
  -- load debug lib
  task.spawn(function()
    getgenv().cds = require 'lib/debugginglib'
    getgenv().debugging = {
      ['connect'] = getgenv().cds,
    }
  end)
  -- transition
  ui.TransitionToUIFrame 'MainUI'
end
debug 'checkauth'
-- if auth failed, register events & show prompt
if not IsSuccessfulAuth then
  -- otherwise, call CompleteUI()
  debug 'ttui'
  ui.PrepareTransition 'Loader'
  CompleteUI()
end

end;
modules['index.lua'].cache = null;
modules['index.lua'].isCached = false;

----

modules['auth/HandleKeyedAuthentication.lua'] = {};
modules['auth/HandleKeyedAuthentication.lua'].load = function()
-- Simple API for Key-based Authentication
return {
  ['ValidateKey'] = function(key)
    if type(key) ~= 'string' then
      error 'Failed to auth'
    end

    local ret = authvf(key, game:GetService('Players').LocalPlayer.Name)
    if ret then
      writefile('.fluxus-auth-store', key)
    end
    return ret
  end,
}

end;
modules['auth/HandleKeyedAuthentication.lua'].cache = null;
modules['auth/HandleKeyedAuthentication.lua'].isCached = false;

----

modules['auth/index.lua'] = {};
modules['auth/index.lua'].load = function()
local auth = {
  ['Keyed'] = require 'auth/HandleKeyedAuthentication',
}
auth['TryAuthenticate'] = function() -- pre-ui-validation, if this function returns true, the auth ui prompt is skipped.
  if _testKeySystem then
    return false
  end
  if authvf('', game:GetService('Players').LocalPlayer.Name) then
    return true
  end

  if isfile '.fluxus-auth-store' then
    return authvf(readfile '.fluxus-auth-store', game:GetService('Players').LocalPlayer.Name)
  end
  return false
end
return auth

end;
modules['auth/index.lua'].cache = null;
modules['auth/index.lua'].isCached = false;

----

modules['patches/HookSetfpscap.lua'] = {};
modules['patches/HookSetfpscap.lua'].load = function()
local setfpscap = getgenv().setfpscap
getgenv().setfpscap = function(cap)
  if typeof(cap) ~= 'number' then
    error '-1iq moment: did not pass number to setfpscap'
  else
    return setfpscap(cap)
  end
end
return setfpscap

end;
modules['patches/HookSetfpscap.lua'].cache = null;
modules['patches/HookSetfpscap.lua'].isCached = false;

----

modules['patches/LoadCfgLib.lua'] = {};
modules['patches/LoadCfgLib.lua'].load = function()
-- loads cfg lib; it adds itself into genv
require 'lib/cfg'

end;
modules['patches/LoadCfgLib.lua'].cache = null;
modules['patches/LoadCfgLib.lua'].isCached = false;

----

modules['patches/PatchAuthListfiles.lua'] = {};
modules['patches/PatchAuthListfiles.lua'].load = function()
-- Patches listfile to prevent accidentally causing an error when matched with readfile()
-- Could be better optimized but idc
local rawListFiles
rawListFiles = hookfunction(listfiles, function(dir, ...)
  local fileList = rawListFiles(dir, ...)
  local returnedList = {}
  for _, file in pairs(fileList) do
    if not string.find(file, '.fluxus-auth-store') then
      table.insert(returnedList, file)
    end
  end
  return returnedList
end)
return rawListFiles

end;
modules['patches/PatchAuthListfiles.lua'].cache = null;
modules['patches/PatchAuthListfiles.lua'].isCached = false;

----

modules['patches/PatchAuthReads.lua'] = {};
modules['patches/PatchAuthReads.lua'].load = function()
-- Patches reads
-- Please DO NOT rely on this alone in production for premium as-is.
local rawReadFile
rawReadFile = hookfunction(readfile, function(f, ...)
  if string.find(f, '.fluxus-auth-store') then
    return ('Security Exception: The file "' .. f .. '" is a protected file and cannot be written to!')
  end
  return rawReadFile(f, ...)
end)
return rawReadFile

end;
modules['patches/PatchAuthReads.lua'].cache = null;
modules['patches/PatchAuthReads.lua'].isCached = false;

----

modules['patches/PatchReadClipboard.lua'] = {};
modules['patches/PatchReadClipboard.lua'].load = function()
local execute_script = readclipboard_hideenv
getgenv().readclipboard_hideenv = nil
return execute_script

end;
modules['patches/PatchReadClipboard.lua'].cache = null;
modules['patches/PatchReadClipboard.lua'].isCached = false;

----

modules['patches/PatchUnavailableDecompiler.lua'] = {};
modules['patches/PatchUnavailableDecompiler.lua'].load = function()
getgenv().decompile = getgenv().decompile or function()
  return '-- no decompiler 4 u'
end

end;
modules['patches/PatchUnavailableDecompiler.lua'].cache = null;
modules['patches/PatchUnavailableDecompiler.lua'].isCached = false;

----

modules['patches/PolyfillRConsole.lua'] = {};
modules['patches/PolyfillRConsole.lua'].load = function()
local nop = function() end
local UI = require 'lib/ui'
local doesrconsoleexist = false
local rconsoletab, rconsoletext, rconsolesearch

local rconsoletextvalue = ''

local rconsolesearchevent = Instance.new 'BindableEvent'

local ensureconsoleexists = function()
  if not doesrconsoleexist then
    rconsoletab = UI:CreateTab 'rbxassetid://11493344192'
    rconsoletab:Focus()
    rconsolesearch = rconsoletab:Create('Search', function(t)
      rconsolesearch:SetVisible(false)
      rconsolesearchevent:Fire(t)
    end)
    rconsolesearch:SetVisible(false)
    rconsoletext = rconsoletab:Create('Text', '')
    rconsoletext:SetRichTextEnabled(false)
    doesrconsoleexist = true
  end
end
local wrapexists = function(urfunc)
  return function(...)
    ensureconsoleexists()
    return urfunc(...)
  end
end

local rconsole = {}

rconsole.print = wrapexists(function(t)
  rconsoletextvalue = rconsoletextvalue .. tostring(t)
  rconsoletext:UpdateText(rconsoletextvalue)
end)
rconsole.clear = wrapexists(function()
  rconsoletextvalue = ''
  rconsole.print ''
end)

rconsole.input = wrapexists(function()
  rconsolesearch:SetVisible(true)
  return rconsolesearchevent.Event:Wait()
end)

rconsole.create = wrapexists(nop)

rconsole.settitle = wrapexists(nop)
rconsole.name = wrapexists(nop)
rconsole.destroy = nop

for k, v in pairs(rconsole) do
  getgenv()['rconsole' .. k] = v
  getgenv()['console' .. k] = v
  getgenv()['rcons' .. k] = v
  getgenv()['cons' .. k] = v
  getgenv()['fluxconsole' .. k] = v
end

end;
modules['patches/PolyfillRConsole.lua'].cache = null;
modules['patches/PolyfillRConsole.lua'].isCached = false;

----

modules['lib/auth.lua'] = {};
modules['lib/auth.lua'].load = function()
local authfunc = authvf
local cache
return function(...)
  cache = cache or authfunc(...) -- if it was unsuccessful, cache will be falsy and be overwritten
  return cache
end

end;
modules['lib/auth.lua'].cache = null;
modules['lib/auth.lua'].isCached = false;

----

modules['lib/base64.lua'] = {};
modules['lib/base64.lua'].load = function()
--!strict
-- Based on https://github.com/iskolbin/lbase64/blob/master/base64.lua
--[[

 base64 -- v1.5.3 public domain Lua base64 encoder/decoder
 no warranty implied; use at your own risk

 Needs bit32.extract function. If not present it's implemented using BitOp
 or Lua 5.3 native bit operators. For Lua 5.1 fallbacks to pure Lua
 implementation inspired by Rici Lake's post:
   http://ricilake.blogspot.co.uk/2007/10/iterating-bits-in-lua.html

 author: Ilya Kolbin (iskolbin@gmail.com)
 url: github.com/iskolbin/lbase64

 COMPATIBILITY

 Lua 5.1+, LuaJIT

 LICENSE

 See end of file for license information.

--]]

local base64 = {}

-- Previously: local extract = _G.bit32 and _G.bit32.extract -- Lua 5.2/Lua 5.3 in compatibility mode
local extract = bit32 and bit32.extract -- Lua 5.2/Lua 5.3 in compatibility mode
if not extract then
  if _G.bit then -- LuaJIT
    local shl, shr, band = _G.bit.lshift, _G.bit.rshift, _G.bit.band
    extract = function(v, from, width)
      return band(shr(v, from), shl(1, width) - 1)
    end
  elseif _G._VERSION == 'Lua 5.1' then
    extract = function(v, from, width)
      local w = 0
      local flag = 2 ^ from
      for i = 0, width - 1 do
        local flag2 = flag + flag
        if v % flag2 >= flag then
          w = w + 2 ^ i
        end
        flag = flag2
      end
      return w
    end
  else -- Lua 5.3+
    extract = load [[return function( v, from, width )
			return ( v >> from ) & ((1 << width) - 1)
		end]]()
  end
end

function base64.makeencoder(s62, s63, spad)
  local encoder = {}
  for b64code, char in pairs {
    [0] = 'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'n',
    'o',
    'p',
    'q',
    'r',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z',
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    s62 or '+',
    s63 or '/',
    spad or '=',
  } do
    encoder[b64code] = char:byte()
  end
  return encoder
end

function base64.makedecoder(s62, s63, spad)
  local decoder = {}
  for b64code, charcode in pairs(base64.makeencoder(s62, s63, spad)) do
    decoder[charcode] = b64code
  end
  return decoder
end

local DEFAULT_ENCODER = base64.makeencoder()
local DEFAULT_DECODER = base64.makedecoder()

local char, concat = string.char, table.concat

function base64.encode(str, encoder, usecaching)
  encoder = encoder or DEFAULT_ENCODER
  local t, k, n = {}, 1, #str
  local lastn = n % 3
  local cache = {}
  for i = 1, n - lastn, 3 do
    local a, b, c = str:byte(i, i + 2)
    local v = a * 0x10000 + b * 0x100 + c
    local s
    if usecaching then
      s = cache[v]
      if not s then
        s =
          char(encoder[extract(v, 18, 6)], encoder[extract(v, 12, 6)], encoder[extract(v, 6, 6)], encoder[extract(v, 0, 6)])
        cache[v] = s
      end
    else
      s = char(encoder[extract(v, 18, 6)], encoder[extract(v, 12, 6)], encoder[extract(v, 6, 6)], encoder[extract(v, 0, 6)])
    end
    t[k] = s
    k = k + 1
  end
  if lastn == 2 then
    local a, b = str:byte(n - 1, n)
    local v = a * 0x10000 + b * 0x100
    t[k] = char(encoder[extract(v, 18, 6)], encoder[extract(v, 12, 6)], encoder[extract(v, 6, 6)], encoder[64])
  elseif lastn == 1 then
    local v = str:byte(n) * 0x10000
    t[k] = char(encoder[extract(v, 18, 6)], encoder[extract(v, 12, 6)], encoder[64], encoder[64])
  end
  return concat(t)
end

function base64.decode(b64, decoder, usecaching)
  decoder = decoder or DEFAULT_DECODER
  local pattern = '[^%w%+%/%=]'
  if decoder then
    local s62, s63
    for charcode, b64code in pairs(decoder) do
      if b64code == 62 then
        s62 = charcode
      elseif b64code == 63 then
        s63 = charcode
      end
    end
    pattern = ('[^%%w%%%s%%%s%%=]'):format(char(s62), char(s63))
  end
  b64 = b64:gsub(pattern, '')
  local cache = usecaching and {}
  local t, k = {}, 1
  local n = #b64
  local padding = b64:sub(-2) == '==' and 2 or b64:sub(-1) == '=' and 1 or 0
  for i = 1, padding > 0 and n - 4 or n, 4 do
    local a, b, c, d = b64:byte(i, i + 3)
    local s
    if usecaching then
      local v0 = a * 0x1000000 + b * 0x10000 + c * 0x100 + d
      s = cache[v0]
      if not s then
        local v = decoder[a] * 0x40000 + decoder[b] * 0x1000 + decoder[c] * 0x40 + decoder[d]
        s = char(extract(v, 16, 8), extract(v, 8, 8), extract(v, 0, 8))
        cache[v0] = s
      end
    else
      local v = decoder[a] * 0x40000 + decoder[b] * 0x1000 + decoder[c] * 0x40 + decoder[d]
      s = char(extract(v, 16, 8), extract(v, 8, 8), extract(v, 0, 8))
    end
    t[k] = s
    k = k + 1
  end
  if padding == 1 then
    local a, b, c = b64:byte(n - 3, n - 1)
    local v = decoder[a] * 0x40000 + decoder[b] * 0x1000 + decoder[c] * 0x40
    t[k] = char(extract(v, 16, 8), extract(v, 8, 8))
  elseif padding == 2 then
    local a, b = b64:byte(n - 3, n - 2)
    local v = decoder[a] * 0x40000 + decoder[b] * 0x1000
    t[k] = char(extract(v, 16, 8))
  end
  return concat(t)
end

return base64

--[[
------------------------------------------------------------------------------
This software is available under 2 licenses -- choose whichever you prefer.
------------------------------------------------------------------------------
ALTERNATIVE A - MIT License
Copyright (c) 2018 Ilya Kolbin
Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
------------------------------------------------------------------------------
ALTERNATIVE B - Public Domain (www.unlicense.org)
This is free and unencumbered software released into the public domain.
Anyone is free to copy, modify, publish, use, compile, sell, or distribute this
software, either in source code form or as a compiled binary, for any purpose,
commercial or non-commercial, and by any means.
In jurisdictions that recognize copyright laws, the author or authors of this
software dedicate any and all copyright interest in the software to the public
domain. We make this dedication for the benefit of the public at large and to
the detriment of our heirs and successors. We intend this dedication to be an
overt act of relinquishment in perpetuity of all present and future rights to
this software under copyright law.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
------------------------------------------------------------------------------
--]]

end;
modules['lib/base64.lua'].cache = null;
modules['lib/base64.lua'].isCached = false;

----

modules['lib/json.lua'] = {};
modules['lib/json.lua'].load = function()
--[[ json.lua

A compact pure-Lua JSON library.
The main functions are: json.stringify, json.parse.

## json.stringify:

This expects the following to be true of any tables being encoded:
 * They only have string or number keys. Number keys must be represented as
   strings in json; this is part of the json spec.
 * They are not recursive. Such a structure cannot be specified in json.

A Lua table is considered to be an array if and only if its set of keys is a
consecutive sequence of positive integers starting at 1. Arrays are encoded like
so: `[2, 3, false, "hi"]`. Any other type of Lua table is encoded as a json
object, encoded like so: `{"key1": 2, "key2": false}`.

Because the Lua nil value cannot be a key, and as a table value is considerd
equivalent to a missing key, there is no way to express the json "null" value in
a Lua table. The only way this will output "null" is if your entire input obj is
nil itself.

An empty Lua table, {}, could be considered either a json object or array -
it's an ambiguous edge case. We choose to treat this as an object as it is the
more general type.

To be clear, none of the above considerations is a limitation of this code.
Rather, it is what we get when we completely observe the json specification for
as arbitrary a Lua object as json is capable of expressing.

## json.parse:

This function parses json, with the exception that it does not pay attention to
\u-escaped unicode code points in strings.

It is difficult for Lua to return null as a value. In order to prevent the loss
of keys with a null value in a json string, this function uses the one-off
table value json.null (which is just an empty table) to indicate null values.
This way you can check if a value is null with the conditional
`val == json.null`.

If you have control over the data and are using Lua, I would recommend just
avoiding null values in your data to begin with.

--]]

-- Minified variant of https://gist.githubusercontent.com/tylerneylon/59f4bcf316be525b30ab/raw/7f69cc2cea38bf68298ed3dbfc39d197d53c80de/json.lua
local a={}local function b(c)if type(c)~='table'then return type(c)end;local d=1;for e in pairs(c)do if c[d]~=nil then d=d+1 else return'table'end end;if d==1 then return'table'else return'array'end end;local function f(g)local h={'\\','"','/','\b','\f','\n','\r','\t'}local i={'\\','"','/','b','f','n','r','t'}for d,j in ipairs(h)do g=g:gsub(j,'\\'..i[d])end;return g end;local function k(l,m,n,o)m=m+#l:match('^%s*',m)if l:sub(m,m)~=n then if o then error('Expected '..n..' near position '..m)end;return m,false end;return m+1,true end;local function p(l,m,q)q=q or''local r='End of input found while parsing string.'if m>#l then error(r)end;local j=l:sub(m,m)if j=='"'then return q,m+1 end;if j~='\\'then return p(l,m+1,q..j)end;local s={b='\b',f='\f',n='\n',r='\r',t='\t'}local t=l:sub(m+1,m+1)if not t then error(r)end;return p(l,m+2,q..(s[t]or t))end;local function u(l,m)local v=l:match('^-?%d+%.?%d*[eE]?[+-]?%d*',m)local q=tonumber(v)if not q then error('Error parsing number at position '..m..'.')end;return q,m+#v end;function a.stringify(c,w)local g={}local x=b(c)if x=='array'then if w then error'Can\'t encode array as key.'end;g[#g+1]='['for d,q in ipairs(c)do if d>1 then g[#g+1]=', 'end;g[#g+1]=a.stringify(q)end;g[#g+1]=']'elseif x=='table'then if w then error'Can\'t encode table as key.'end;g[#g+1]='{'for y,z in pairs(c)do if#g>1 then g[#g+1]=', 'end;g[#g+1]=a.stringify(y,true)g[#g+1]=':'g[#g+1]=a.stringify(z)end;g[#g+1]='}'elseif x=='string'then return'"'..f(c)..'"'elseif x=='number'then if w then return'"'..tostring(c)..'"'end;return tostring(c)elseif x=='boolean'then return tostring(c)elseif x=='nil'then return'null'elseif x =='function' then return 'null' else error('Unjsonifiable type: '..x..'.')end;return table.concat(g)end;a.null={}function a.parse(l,m,A)m=m or 1;if m>#l then error'Reached unexpected end of input.'end;local m=m+#l:match('^%s*',m)local B=l:sub(m,m)if B=='{'then local c,C,D={},true,true;m=m+1;while true do C,m=a.parse(l,m,'}')if C==nil then return c,m end;if not D then error'Comma missing between object items.'end;m=k(l,m,':',true)c[C],m=a.parse(l,m)m,D=k(l,m,',')end elseif B=='['then local E,q,D={},true,true;m=m+1;while true do q,m=a.parse(l,m,']')if q==nil then return E,m end;if not D then error'Comma missing between array items.'end;E[#E+1]=q;m,D=k(l,m,',')end elseif B=='"'then return p(l,m+1)elseif B=='-'or B:match'%d'then return u(l,m)elseif B==A then return nil,m+1 else local F={['true']=true,['false']=false,['null']=a.null}for G,H in pairs(F)do local I=m+#G-1;if l:sub(m,I)==G then return H,I+1 end end;local J='position '..m..': '..l:sub(m,m+10)error('Invalid json syntax starting at '..J)end end;return a

end;
modules['lib/json.lua'].cache = null;
modules['lib/json.lua'].isCached = false;

----

modules['lib/rgb.lua'] = {};
modules['lib/rgb.lua'].load = function()
return Color3.fromRGB

end;
modules['lib/rgb.lua'].cache = null;
modules['lib/rgb.lua'].isCached = false;

----

modules['lib/cfg/index.lua'] = {};
modules['lib/cfg/index.lua'].load = function()
local file, json = '.fsettings.json', require 'lib/json'
local data = {}
local success, err = pcall(function()
  data = isfile(file) and json.parse(readfile(file)) or {}
end)
if not success then
  pcall(function()
    writefile('fluxus_cfg.json.bak', readfile(file))
    delfile(file);
    data = {};
  end)
end

local API
API = {
  ['_load'] = {
    success = success,
    err = err,
  },
  ['save'] = function(self)
    writefile(file, json.stringify(data))
    return self
  end,
  ['new'] = function(idx, defaults)
    if not idx then
      error 'Did not specify a script settings name!'
    end
    if typeof(data[idx]) ~= 'table' then
      data[idx] = {}
    end
    if defaults and typeof(defaults) ~= 'table' then
      error 'defaults must be table or nil'
    end
    for k, v in pairs(defaults or {}) do
      if typeof(data[idx][k]) == 'nil' then
        data[idx][k] = v
      end
      if typeof(v) == 'table' and typeof(data[idx][k]) == 'table' then
        for k2, v2 in pairs(v) do
          if typeof(data[idx][k][k2]) == 'nil' then
            data[idx][k][k2] = v2
          end
        end
      end
    end
    local s
    s = {
      ['save'] = function(self)
        API:save()
        return self
      end,
      ['get'] = function(_, k)
        if typeof(_) == 'string' then
          k = _
        end
        return data[idx][k]
      end,
      ['set'] = function(_, k, v)
        if typeof(_) == 'string' then
          k = _
          v = k
          _ = nil
        end
        data[idx][k] = v
        API:save()
        return _ or s
      end,
      ['getAll'] = function()
        return data[idx]
      end,
      ['setAll'] = function(_, v)
        if not v then
          v = _
          _ = nil
        end
        if typeof(v) ~= 'table' then
          error 'cannot call setAll without value being a table'
        end
        data[idx] = v
        API:save()
        return s or _
      end,
    }
    return s
  end,
}
getgenv().cfgapi = API
getgenv().Cfg = API
getgenv().cfg_api = API
return API

end;
modules['lib/cfg/index.lua'].cache = null;
modules['lib/cfg/index.lua'].isCached = false;

----

modules['lib/scriptblox/index.lua'] = {};
modules['lib/scriptblox/index.lua'].load = function()
local ScriptBlox = {}

ScriptBlox.Search = require 'lib/scriptblox/search'

getgenv().ScriptBloxAPI = ScriptBlox

return ScriptBlox

end;
modules['lib/scriptblox/index.lua'].cache = null;
modules['lib/scriptblox/index.lua'].isCached = false;

----

modules['lib/scriptblox/search.lua'] = {};
modules['lib/scriptblox/search.lua'].load = function()
-- scriptblox api schema for https://scriptblox.com/api/script/search?q=%s&max=%s&mode=%s
-- result: // no, this isnt for formatting, its the actual key
--   totalPages: int16 // might be more, however its not gonna be above that, should honestly be interpereted as an int8 & anything beyond it should be dismissed - this is lua though
--   scripts: script[]
--     - _id: string
--       title: string
--       game: game
--         gameId: int64
--         name: string
--         imageUrl: `/images/${string}`
--       slug: string // no spaces, ie 2X-EXP-or-Anime-Dimensions-Simulator-Anime-Dimensions-Simulator-Script-6715
--       verified: boolean
--       views: int
--       scriptType: 'free' | 'paid'
--       isUniversal: boolean
--       isPatched: boolean // if true, we should ignore it altogether | the ui just marks it at patched on the site
--       visibility: 'public' // can be other things (unlisted | private), but not for search responses
--       rawCount: int64 // ??
--       showRawCount: boolean // ??
--       createdAt: string // iso time
--       updatedAt: string // iso time
--       __v: number // ??
--       script: string // push this to the queue on exec
--       matched: string[] // list of matched features

local endpoint = 'https://scriptblox.com/api/script/search?q=%s%s&mode=free'
local queryEndpoint = 'https://scriptblox.com/api/script/%s'

local j = require 'lib/json'

local cache = {}

return function(q, mx)
  if cache[tostring(q) .. '++' .. tostring(mx)] then
    return cache[tostring(q) .. '++' .. tostring(mx)]
  end
  -- transform input
  q = string.gsub(q, ' ', '+')
  mx = mx and string.format('&max=%s', tostring(mx)) or ''
  -- make api call
  local responseRaw = game:HttpGetAsync(string.format(endpoint, q, mx))
  -- parse
  local parsed = j.parse(responseRaw)
  for _, script in pairs(parsed.result.scripts) do
    -- add queryInfo call
    script.queryInfo = function()
      if cache['_info.' .. script._id] then
        return cache['_info.' .. script._id]
      end
      local slug = script.slug
      local infoAPI = string.format(queryEndpoint, slug)
      local fetched = game:HttpGetAsync(infoAPI)
      cache['_info.' .. script._id] = j.parse(fetched).script
      return cache['_info.' .. script._id]
    end
  end
  -- return
  cache[tostring(q) .. '++' .. tostring(mx)] = parsed
  return cache[tostring(q) .. '++' .. tostring(mx)]
end

end;
modules['lib/scriptblox/search.lua'].cache = null;
modules['lib/scriptblox/search.lua'].isCached = false;

----

modules['lib/debugginglib/index.lua'] = {};
modules['lib/debugginglib/index.lua'].load = function()
local strlib = {
  ['startsWith'] = function(str, substr)
    return string.sub(str, 1, #substr) == substr
  end,
  ['endsWith'] = function(str, substr)
    return string.sub(str, -#substr) == substr
  end,
}
local json = require 'lib/json'
local b64 = require 'lib/base64'
local bb64 = {
  ['encode'] = function(d)
    return string.gsub(b64.encode(d), '/', '_')
  end,
  ['decode'] = function(d)
    return b64.decode(string.gsub(d, '_', '/'))
  end,
}

local existingConnections = {}
local connect = function(address)
  if not strlib.endsWith(address, '/') then
    address = address .. '/'
  end
  if existingConnections[address] then
    return existingConnections[address]
  end
  local connection = {}
  connection.request = function(r)
    return game:HttpGetAsync(address .. r)
  end
  if connection.request 'isalive' ~= 'alive' then
    error 'Instance is not alive. Possibly pointing to something other than the communication assistant?'
  end
  -- Comms Assistant
  do
    connection.assistant = {
      ['console'] = {
        ['clear'] = function()
          return connection.request 'clear-console'
        end,
        ['log'] = function(_t, t)
          return connection.request('send-console/' .. bb64.encode(typeof(t) == 'nil' and _t or t))
        end,
      },
    }
    connection.assistant.console.clear()
    connection.assistant.console.log(
      'Connection to Android Device Established at .DATE.!\nPlease point your SDK or Application to '
        .. address
        .. '\nPress CTRL+C to end the connection.'
    )
  end
  -- Jobs (SDK -> Client)
  do
    -- Public API
    local runners = {}
    do
      connection.on = function(jobName, callback)
        if not jobName then
          error 'Provide an event name'
        end
        if typeof(jobName) ~= 'string' then
          error 'Ensure your event\'s name is a string'
        end
        runners[jobName] = callback
      end
    end
    -- Long-Poll
    do
      local Poll = function()
        local response = json.parse(connection.request 'android/long-poll')
        local jobs = response.jobs
        for _, o in pairs(jobs) do
          if runners[o.type] then
            task.spawn(function()
              runners[o.type](o.data)
            end)
          end
        end
      end
      task.spawn(function()
        while true do
          local s, e = pcall(function()
            Poll()
          end)
          if not s then
            warn(e)
            task.wait(30)
          end
          task.wait()
        end
      end)
    end
  end
  -- Client -> SDK
  do
    connection.bulkSend = function(jobs)
      local stringed = json.stringify(jobs)
      local b64ed = bb64.encode(stringed)
      return connection.request('android/send-jobs/' .. b64ed)
    end
    connection.send = function(jobName, data)
      if not jobName then
        error 'Provide an event name'
      end
      if typeof(jobName) ~= 'string' then
        error 'Ensure your event\'s name is a string'
      end
      return connection.bulkSend {
        ['type'] = jobName,
        ['data'] = data,
      }
    end
  end
  require(__dirname .. '/jobs')(connection)
  existingConnections[address] = connection
  return connection
end
return connect

end;
modules['lib/debugginglib/index.lua'].cache = null;
modules['lib/debugginglib/index.lua'].isCached = false;

----

modules['lib/debugginglib/jobs/index.lua'] = {};
modules['lib/debugginglib/jobs/index.lua'].load = function()
-- Built-In Jobs
return function(connection)
  connection.on('loadstring', require(__dirname .. '/loadstring')(connection))
end

end;
modules['lib/debugginglib/jobs/index.lua'].cache = null;
modules['lib/debugginglib/jobs/index.lua'].isCached = false;

----

modules['lib/debugginglib/jobs/loadstring.lua'] = {};
modules['lib/debugginglib/jobs/loadstring.lua'].load = function()
return function(connection)
  return function(data)
    if typeof(data) ~= 'string' then
      return connection.send('exception', {
        ['for'] = 'loadstring',
        ['script'] = data,
        ['exception'] = 'parser exception: is not string',
      })
    end
    getgenv().___temp_connection = connection
    getgenv().___temp_connection_print = function(...)
      return connection.send('connectionPrint', table.concat({ ... }, ' '))
    end
    data = 'local connection=getgenv().___temp_connection;getgenv().___temp_connection=nil;local connectionPrint=getgenv().___temp_connection_print;getgenv().___temp_connection_print=nil;'
      .. data
    local chunk, exc = loadstring(data, tostring(math.random(0, 100000000)))
    if not chunk then
      return connection.send('exception', {
        ['for'] = 'loadstring',
        ['script'] = data,
        ['exception'] = 'compilation exception: ' .. tostring(exc),
      })
    end
    local s, r = pcall(chunk, connection)
    if not s then
      return connection.send('exception', {
        ['for'] = 'loadstring',
        ['script'] = data,
        ['exception'] = 'runtime exception: ' .. tostring(r),
      })
    end
  end
end

end;
modules['lib/debugginglib/jobs/loadstring.lua'].cache = null;
modules['lib/debugginglib/jobs/loadstring.lua'].isCached = false;

----

modules['lib/ui/CreateBaseUI.lua'] = {};
modules['lib/ui/CreateBaseUI.lua'].load = function()
-- Creates the main UI using primarily the public API
local UI = require 'lib/ui'
local UIFH = require 'lib/ui/_UIFeatureHandler'
local CFGLib = require 'lib/cfg'
local a = require('asset-obj')
return function()
  -- main/exec page
  local tab = UI:CreateTab(a['rbxassetid://11445282332'])
  if not CFGLib._load.success then

  end
  UIFH.add('tabimages', tab:Create('Image', a['rbxassetid://11440677815']))
  tab:Create(
    'Text',
    _G.fluxus_ui_values["welcome_text"]
  )
  tab:Create 'ExecBox'
  UIFH.add('tabimages', tab:Create('Image', a['rbxassetid://11445329779']))
  tab:Create(
    'Text',
    _G.fluxus_ui_values["credits"]
  )
end

end;
modules['lib/ui/CreateBaseUI.lua'].cache = null;
modules['lib/ui/CreateBaseUI.lua'].isCached = false;

----

modules['lib/ui/CreateHistoryUI.lua'] = {};
modules['lib/ui/CreateHistoryUI.lua'].load = function()
local UI = require 'lib/ui'
local UIFH = require 'lib/ui/_UIFeatureHandler'
local CFGLib = require 'lib/cfg'
local executescript = require 'patches/PatchReadClipboard'
local aobj = require('asset-obj')
local cfg = CFGLib.new('li.flux.ui.builtins', {
  ['history'] = {},
})
local hasCreated = false
local add
local pushToScriptHistory = function(self, item)
  add(item)
  local history = cfg:get 'history'
  -- trim
  if #history > 51 then
    local newHistory = {}
    local amnt = #history - 50
    for i = amnt, #history, 1 do
      table.insert(newHistory, history[i])
    end
    history = newHistory
  end
  table.insert(history, item)
  cfg:set('history', history)
end
return setmetatable({}, {
  __call = function()
    if hasCreated then
      return
    else
      hasCreated = true
    end
    -- history page
    local tab = UI:CreateTab(aobj['rbxassetid://11706698017'])
    UIFH.add('tabimages', tab:Create('Image', aobj['rbxassetid://11706521913']))
    add = function(s)
      local strDisplay = string.sub(s, 0, 15)
      if #s > 15 then
        strDisplay = strDisplay .. '...'
      end
      UIFH.add(
        'scripthistory',
        tab:Create('Button', 'passive', 'Run', strDisplay, function()
          executescript(s)
        end)
      )
    end
    for _, o in pairs(cfg:get 'history') do
      add(o)
    end
    UIFH.add('!scripthistory', tab:Create('Text', 'Rejoin to hide this tab.'))
  end,
  __index = {
    ['\0\1\2\3\4\5\6\7\8\9\240\241\242\243\244\245\246\247\248\249\250\251\252\253\254\255'] = pushToScriptHistory,
  },
})

end;
modules['lib/ui/CreateHistoryUI.lua'].cache = null;
modules['lib/ui/CreateHistoryUI.lua'].isCached = false;

----

modules['lib/ui/CreateScriptBloxUI.lua'] = {};
modules['lib/ui/CreateScriptBloxUI.lua'].load = function()
local ScriptBlox = require 'lib/scriptblox'
local UIMain = require 'lib/ui'
local executescript = require 'patches/PatchReadClipboard'
local CFGLib = require 'lib/cfg'
local UIFH = require 'lib/ui/_UIFeatureHandler'
local cfg = CFGLib.new 'li.flux.ui.builtins'
local assets = require('asset-obj')
return function()
  local tab = UIMain:CreateTab(assets['rbxassetid://11810985691'])
  UIFH.add('tabimages', tab:Create('Image', assets['rbxassetid://11441550965']))
  local entries = {}
  local clear = function()
    for _, o in pairs(entries) do
      o:SetVisible(false)
    end
    entries = {}
  end
  if not isfolder '.fluxus-scriptblox-autoexec' then
    makefolder '.fluxus-scriptblox-autoexec'
  end
  task.spawn(function()
    local add = function(data)
      -- table.insert(entries, UIFH.add('tabimages', tab:Create 'Image'))
      table.insert(
        entries,
        tab:Create(
          'Text',
          string.format(
            '<font size="28"><b>%s</b></font><br/><font size="24">Matched: <i>%s</i></font>',
            data.title,
            table.concat(data.matched, ' ')
          )
        )
      )
      if data.isUniversal and data._id then
        local btn
        local updateButton
        local fpath = '.fluxus-scriptblox-autoexec/' .. data._id .. '.autoexec.json'
        local cb = function()
          if isfile(fpath) then
            delfile(fpath)
          else
            writefile(fpath, require('lib/json').stringify(data))
          end
          updateButton()
        end
        updateButton = function()
          if isfile(fpath) then
            btn:Update('passive', 'Remove from autoexec')
          else
            btn:Update('passive', 'Add to autoexec')
          end
        end
        btn = UIFH.add('autoexec', tab:Create('Button', 'passive', 'Add to autoexec', cb))
        updateButton()
        table.insert(entries, btn)
      end
      local btn = tab:Create('Button', 'passive', 'Execute', function()
        if executescript then
          executescript(data.script)
        else
          local bytecode, err = loadstring(data.script)
          if not err then
            bytecode()
          else
            error('Compilation Error! Info: ' .. err)
          end
        end
      end)
      table.insert(entries, btn)
    end
    -- run autoexec
    task.spawn(function()
      if cfg:get 'noautoexec' then
        return
      end
      for _, o in pairs(listfiles '.fluxus-scriptblox-autoexec') do
        local fraw = readfile(o)
        local data = require('lib/json').parse(fraw)
        if executescript then
          executescript(data.script)
        else
          local bytecode, err = loadstring(data.script)
          if not err then
            bytecode()
          else
            error('Compilation Error! Info: ' .. err)
          end
        end
      end
    end)
    local doSearch = function(query, deep)
      -- get results
      local apiresults = nil;
      local s,e = pcall(function()
          apiresults = ScriptBlox.Search(query, 60).result.scripts
      end)
      if s == false then
        return;
      end
      -- sort by pref
      local results = {}
      -- ensure can be sorted correctly
      for i = -50, 50, 1 do
        results[i] = nil
      end
      local androidMatches = {
        'fluxus android',
        'flux android',
        'fluxusandroid',
        'mobile',
        'android',
        '-- @supports-fluxus-android',
        '-- @supports-mobile-ui',
      }
      for idx, res in pairs(apiresults) do
        local cat = 32
        -- supports fluxus android = prioritize by 3
        for _, o in pairs(androidMatches) do
          if
            string.find(string.lower(res.title), o) or string.find(string.lower(res.script), o)
            -- or (deep and string.find(string.lower(res.queryInfo().features), o)) -- buggy for some searches no clue why
          then
            cat = cat - 5
            table.insert(res.matched, 'compatability')
            break
          end
        end
        -- game id matches = prioritize by 2
        if game.GameId == res.game.gameId then
          cat = cat - 2
          table.insert(res.matched, 'gameid')
        end
        -- universal = prioritize by 1
        if res.isUniversal then
          cat = cat - 1
          table.insert(res.matched, 'universal')
        end
        -- verified = prioritize by 1
        if res.verified then
          cat = cat - 1
          table.insert(res.matched, 'verified')
        end
        -- is patched = deprioritize by 50
        if res.isPatched then
          cat = cat + 50
          res.title = 'PATCHED | ' .. res.title
        end
        -- insert
        results[cat] = results[cat] or {}
        table.insert(results[cat], res)
      end
      -- clear ui
      clear()
      -- add
      for _, resList in pairs(results) do
        for _, res in pairs(resList or {}) do
          add(res)
        end
      end
    end
    tab:Create('Search', function(v)
      doSearch(v, true)
    end)
    task.spawn(function()
      doSearch('', false)
    end)
  end)
end

end;
modules['lib/ui/CreateScriptBloxUI.lua'].cache = null;
modules['lib/ui/CreateScriptBloxUI.lua'].isCached = false;

----

modules['lib/ui/CreateScriptsUI.lua'] = {};
modules['lib/ui/CreateScriptsUI.lua'].load = function()
local UIMain = require 'lib/ui'
local UIFH = require 'lib/ui/_UIFeatureHandler'
local executescript = require 'patches/PatchReadClipboard'
getgenv().getScriptList = function()
  error 'public getScriptList API not available yet.'
end
local assets = require('asset-obj')
return function()
  local tab = UIMain:CreateTab(assets['rbxassetid://11447575636'])
  task.spawn(function()
    UIFH.add('tabimages', tab:Create('Image', assets['rbxassetid://11441550965']))
    local scripts = getscripts()
    if typeof(scripts) == 'nil' then
      tab:Create('Text', '<font size="26">Permission Missing</font>')
      tab:Create('Text', 'Please grant Roblox the \'Storage\'->\'All Files\' Permission.')
      local btn
      btn = tab:Create('Button', 'active', 'Instructions', function()
        task.spawn(function()
          setclipboard 'https://www.youtube.com/watch?v=EQxJSeif9b8'
          btn:Update('passive', 'Copied to your Clipboard.')
          task.wait(2)
          btn:Update('active', 'Instructions')
        end)
      end)
      tab:Create('Text', '<font size="13" color="#999999">Error: 0x00</font>')
    elseif scripts == -1 then
      tab:Create('Text', '<font size="26">Outdated Fluxus</font>')
      tab:Create('Text', 'Update Fluxus to access the Scripts tab.')
      tab:Create('Text', '<font size="13" color="#999999">Error: 0x01</font>')
    else
      local noScript = {
        tab:Create('Text', '<font size="26">No Scripts</font>'),
        tab:Create(
          'Text',
          'Add Scripts to the \'Main Storage -> Fluxus -> Scripts\' Directory & they\'ll show here once you rejoin.'
        ),
        tab:Create('Text', '<font size="13" color="#999999">Error: 0x02</font>'),
      }
      for name, val in pairs(scripts) do
        for _, o in pairs(noScript) do
          o:SetVisible(false)
        end
        noScript = {}
        name = string.gsub(name, '.lua', ''):gsub('.txt', '')
        tab:Create('Button', 'passive', 'Run', name, function()
          executescript(val)
        end)
      end
    end
  end)
end

end;
modules['lib/ui/CreateScriptsUI.lua'].cache = null;
modules['lib/ui/CreateScriptsUI.lua'].isCached = false;

----

modules['lib/ui/CreateSettingsUI.lua'] = {};
modules['lib/ui/CreateSettingsUI.lua'].load = function()
-- Creates the main UI using primarily the public API
local UI, CFGLib, UIFH = require 'lib/ui', require 'lib/cfg', require 'lib/ui/_UIFeatureHandler'
local cfg, betas = CFGLib.new 'li.flux.ui.builtins', CFGLib.new 'li.flux.ui.betaflags'
local assets = require('asset-obj')
return function()
  if cfg:get 'scripthistory' then
    require 'lib/ui/CreateHistoryUI'()
  end
  local tab = UI:InternalCreateTab(assets['rbxassetid://11447558233'], 'y999999')
  UIFH.add('tabimages', tab:Create('Image', assets['rbxassetid://11441541927']))

  -- define funcs
  local SetSmallUI = function(v)
    UI:SetSmallUIEnabled(v)
    cfg:set('usesmallui', v)
  end
  local SetIsFPSUnlocked = function(v)
    setfpscap(v and 512 or 60)
    cfg:set('fpsunlocked', v)
  end
  local SetNoAutoexec = function(v)
    cfg:set('noautoexec', v)
    UIFH.changeState('autoexec', not v)
  end
  local SetPurchaseProtections = function(v)
    setpurchaseprotections(v)
    cfg:set('purchaseprotections', v)
    --UIFH.changeState('purchaseprotections', not v)
  end
  local SetFastAnim = function(v)
    cfg:set('fastanim', v)
  end
  local SetNoAnim = function(v)
    cfg:set('noanim', v)
    UIFH.changeState('noanim', v)
  end
  local SetTabImages = function(v)
    cfg:set('tabimages', v)
    UIFH.changeState('tabimages', v)
  end
  local SetScrHst = function(v)
    cfg:set('scripthistory', v)
    UIFH.changeState('scripthistory', v)
    if v then
      require 'lib/ui/CreateHistoryUI'()
    end
  end
  local t = UI.UIFrames.ToggleBtn
  local MinimizePos, MinimizeAnchor = t.Position, t.AnchorPoint
  local SetUseCenteredMinimize = function(v)
    if v then
      t.Position = UDim2.new(0.5, 0, 0, 0)
      t.AnchorPoint = Vector2.new(0.5, 0)
    else
      t.Position = MinimizePos
      t.AnchorPoint = MinimizeAnchor
    end
    cfg:set('centeredminimize', v)
  end
  SetSmallUI(cfg:get 'usesmallui')
  SetIsFPSUnlocked(cfg:get 'fpsunlocked')
  SetUseCenteredMinimize(cfg:get 'centeredminimize')
  SetPurchaseProtections(true)
  tab:Create('Text', '<b>UI</b>')
  tab:Create('Checkbox', _G.fluxus_ui_values["small_ui"], cfg:get 'usesmallui').Changed:Connect(SetSmallUI)
  tab:Create('Checkbox', _G.fluxus_ui_values["centeredminimize"], cfg:get 'centeredminimize').Changed:Connect(SetUseCenteredMinimize)
  local showTab = tab:Create('Checkbox', _G.fluxus_ui_values["tabimages"], cfg:get 'tabimages')
  --
  tab:Create('Text', '<b>Execution</b>')
  tab:Create('Checkbox', _G.fluxus_ui_values["noautoexec"], cfg:get 'noautoexec').Changed:Connect(SetNoAutoexec)
  UIFH.add(
    'autoexec',
    tab:Create('Button', 'passive', 'Clear', _G.fluxus_ui_values["clearautoexec"], function()
      for _, o in pairs(listfiles '.fluxus-scriptblox-autoexec') do
        delfile(o)
      end
    end)
  )
  tab:Create('Checkbox', _G.fluxus_ui_values["purchaseprotections"], cfg:get 'purchaseprotections').Changed:Connect(SetPurchaseProtections)
  showTab.Changed:Connect(SetTabImages)
  showTab:SetVisible(cfg:get 'tabimages-option')
  if not cfg:get 'tabimages-option' then
    cfg:set('tabimages-option', false)
  end
  UIFH.changeState('autoexec', not cfg:get 'noautoexec')
  UIFH.changeState('tabimages', cfg:get 'tabimages' or false)
  SetScrHst(cfg:get 'scripthistory')
  --
  tab:Create('Text', '<b>Animations</b>')
  tab:Create('Checkbox', _G.fluxus_ui_values["fastanim"], cfg:get 'fastanim').Changed:Connect(SetFastAnim)
  tab:Create('Checkbox', _G.fluxus_ui_values["noanim"], cfg:get 'noanim').Changed:Connect(SetNoAnim)
  --
  tab:Create('Text', '<b>Beta Features</b>')
  tab:Create('Checkbox', _G.fluxus_ui_values["scripthistory"], cfg:get 'scripthistory').Changed:Connect(SetScrHst)
  --
  -- tab:Create('Text', '<b>Developer</b> Features')
  -- local rdb
  -- rdb = tab:Create('Button','passive','Enable Remote Debugging',function(v)
  --   rdb:SetVisible(false)
  --   local lipc = {}
  --   table.insert(lipc,tab:Create('Text', '<i>Insert the LAN IP to connect to:</i>'))
  -- end)
  --
  tab:Create('Text', '<b>Other</b>')
  tab:Create('Checkbox', 'Unlock FPS', cfg:get 'fpsunlocked').Changed:Connect(SetIsFPSUnlocked)
end

end;
modules['lib/ui/CreateSettingsUI.lua'].cache = null;
modules['lib/ui/CreateSettingsUI.lua'].isCached = false;

----

modules['lib/ui/CreateUI.lua'] = {};
modules['lib/ui/CreateUI.lua'].load = function()
-- Gui to Lua
-- Version: 3.2
local rtContainer = Instance.new 'Part'
local a = require('asset-obj')

-- Instances:

local Global_Image = nil;
local Global_Button_Color = Color3.fromRGB(141, 115, 176)
local Global_Text_Color = Color3.fromRGB(255, 255, 255)
local Global_Tabs_Color = Color3.fromRGB(30, 32, 48)
local Global_Editor_Color = Color3.fromRGB(24, 25, 38);
local Global_Editor_Transparent = false;



_G.fluxus_ui_values = 
{
  -- Key Section

  ["key_instructions"] = 'Welcome to Fluxus Android!<br/>Please click \'Get Key\' to get a key.<br/>Once you\'ve completed the key system, enter your key below, then click \'Check Key\'',
  ["key_paste_key_here"] = 'Paste your key here',
  ["key_get_key"] = 'Get Key',
  ["key_check_key"] = 'Check Key',
  ["key_copied"] = 'Welcome to Fluxus Android!<br/>The key link was copied to your clipboard - Please open it in a browser.<br/>Need help? Join discord.gg/',

  -- Main UI

  ["welcome_text"] = '<font size="24">Hello and Welcome to Fluxus Android!</font><br/>Enter your script or use the games tab on the left',
  ["execute_from_textbox"] = 'Execute from Textbox',
  ["execute_from_clipboard"] = 'Execute from Clipboard',
  ["credits"] = 'Enjoy the keyless version of Fluxus Android. Made by _nath.zi (https://getrift.lol/)';

  -- Cloud Scripts

  ["submit_query"] = 'Submit',
  ["search_query_text"] = 'Search Query | Powered by scriptblox.com',

  -- Settings

  ["small_ui"] = 'Small UI',
  ["centeredminimize"] = 'Use Centered Minimize',  
  ["tabimages"] = 'Show Tab Images',
  ["noautoexec"] = 'Ignore Autoexec',
  ["clearautoexec"] = 'Clear Autoexec',
  ["fastanim"] = 'Fast Animations',
  ["noanim"] = 'No Animations',
  ["scripthistory"] = 'Script History',
  ["purchaseprotections"] = 'Toggle Purchase Protections',
}

local LocalizationService = game:GetService("LocalizationService")
local player = game.Players.LocalPlayer

local result, code = pcall(function()
	return LocalizationService:GetCountryRegionForPlayerAsync(player)
end)

if result then
    if code == "PR" or code == "BR" or code == "CV" or code == "AO" or code == "MZ" then
      _G.fluxus_ui_values["key_instructions"] = 'Bem-vindo ao Fluxus Android!<br/>Por favor, pressione \'Obter chave\' para obter uma chave.<br/>Depois de terminar o sistema de chave, pressione \'Verify Key\'';
      _G.fluxus_ui_values["key_paste_key_here"] = 'Cole sua chave aqui';
      _G.fluxus_ui_values["key_get_key"] = 'Obter chave';
      _G.fluxus_ui_values["key_check_key"] = 'Verificar chave';
      _G.fluxus_ui_values["key_copied"] = 'Bem-vindo ao Fluxus Android!<br/>O link da chave foi copiado! Abra-o em um navegador como o Google.<br/>Preciso de ajuda? Junte-se ao nosso Discord discord.gg/';

      _G.fluxus_ui_values["welcome_text"] = '<font size="24">OlÃƒÂ¡ e bem-vindo ao Fluxus Android!</font><br/>Digite seu script ou use a aba de jogos Ãƒ  esquerda';
      _G.fluxus_ui_values["execute_from_textbox"] = 'Executar script da caixa de texto';
      _G.fluxus_ui_values["execute_from_clipboard"] = 'Executar script copiado';
      _G.fluxus_ui_values["credits"] = 'Fluxus Android foi criado por:<br/>- ShowerHeadFD<br/>- Rev<br/>- YieldingExploiter<br/><br/><i>SeÃƒÂ§ÃƒÂ£o de script alimentada por scriptblox.com</i><br/>Encontre mais produtos em <i>flux.li</i>';
    
      _G.fluxus_ui_values["submit_query"] = "Procurar";
      _G.fluxus_ui_values["search_query_text"] = 'Pesquisar scripts | Fornecido por scriptblox.com';

      _G.fluxus_ui_values["small_ui"] = 'Gui pequeno';
      _G.fluxus_ui_values["centeredminimize"] = 'Centralizado Minimizar';
      _G.fluxus_ui_values["tabimages"] = 'Mostrar Imagens da Aba';
      _G.fluxus_ui_values["noautoexec"] = 'Ignorar execuÃƒÂ§ÃƒÂ£o automÃƒÂ¡tica';
      _G.fluxus_ui_values["clearautoexec"] = 'Limpar execuÃƒÂ§ÃƒÂ£o automÃƒÂ¡tica';
      _G.fluxus_ui_values["fastanim"] = 'AnimaÃƒÂ§ÃƒÂµes rÃƒÂ¡pidas';
      _G.fluxus_ui_values["noanim"] = 'Sem animaÃƒÂ§ÃƒÂµes';
      _G.fluxus_ui_values["scripthistory"] = 'HistÃƒÂ³ria do script';
      _G.fluxus_ui_values["purchaseprotections"] = 'Alternar proteÃ§Ãµes de compra';
    elseif code == "RU" then
      _G.fluxus_ui_values["key_instructions"] = 'Ãâ€ÃÂ¾ÃÂ±Ã‘â‚¬ÃÂ¾ ÃÂ¿ÃÂ¾ÃÂ¶ÃÂ°ÃÂ»ÃÂ¾ÃÂ²ÃÂ°Ã‘â€šÃ‘Å’ ÃÂ² Fluxus Android!<br/>ÃÅ¸ÃÂ¾ÃÂ¶ÃÂ°ÃÂ»Ã‘Æ’ÃÂ¹Ã‘ÂÃ‘â€šÃÂ°, ÃÂ½ÃÂ°ÃÂ¶ÃÂ¼ÃÂ¸Ã‘â€šÃÂµ \'ÃÅ¸ÃÂ¾ÃÂ»Ã‘Æ’Ã‘â€¡ÃÂ¸Ã‘â€šÃ‘Å’ ÃÂºÃÂ»Ã‘Å½Ã‘â€¡\', Ã‘â€¡Ã‘â€šÃÂ¾ÃÂ±Ã‘â€¹ ÃÂ¿ÃÂ¾ÃÂ»Ã‘Æ’Ã‘â€¡ÃÂ¸Ã‘â€šÃ‘Å’ ÃÂºÃÂ»Ã‘Å½Ã‘â€¡.<br/>ÃÅ¸ÃÂ¾Ã‘ÂÃÂ»ÃÂµ ÃÂ·ÃÂ°ÃÂ²ÃÂµÃ‘â‚¬Ã‘Ë†ÃÂµÃÂ½ÃÂ¸Ã‘Â Ã‘ÂÃÂ¸Ã‘ÂÃ‘â€šÃÂµÃÂ¼Ã‘â€¹ ÃÂºÃÂ»Ã‘Å½Ã‘â€¡ÃÂµÃÂ¹ ÃÂ²ÃÂ²ÃÂµÃÂ´ÃÂ¸Ã‘â€šÃÂµ Ã‘ÂÃÂ²ÃÂ¾ÃÂ¹ ÃÂºÃÂ»Ã‘Å½Ã‘â€¡ ÃÂ½ÃÂ¸ÃÂ¶ÃÂµ, ÃÂ·ÃÂ°Ã‘â€šÃÂµÃÂ¼ ÃÂ½ÃÂ°ÃÂ¶ÃÂ¼ÃÂ¸Ã‘â€šÃÂµ \'ÃÅ¸Ã‘â‚¬ÃÂ¾ÃÂ²ÃÂµÃ‘â‚¬ÃÂ¸Ã‘â€šÃ‘Å’ ÃÂºÃÂ»Ã‘Å½Ã‘â€¡\'';
      _G.fluxus_ui_values["key_paste_key_here"] = 'Ãâ€™Ã‘ÂÃ‘â€šÃÂ°ÃÂ²Ã‘Å’Ã‘â€šÃÂµ Ã‘ÂÃ‘Å½ÃÂ´ÃÂ° Ã‘ÂÃÂ²ÃÂ¾ÃÂ¹ ÃÂºÃÂ»Ã‘Å½Ã‘â€¡';
      _G.fluxus_ui_values["key_get_key"] = 'ÃÅ¸ÃÂ¾ÃÂ»Ã‘Æ’Ã‘â€¡ÃÂ¸Ã‘â€šÃ‘Å’ ÃÂºÃÂ»Ã‘Å½Ã‘â€¡';
      _G.fluxus_ui_values["key_check_key"] = 'ÃÅ¸Ã‘â‚¬ÃÂ¾ÃÂ²ÃÂµÃ‘â‚¬ÃÂ¸Ã‘â€šÃ‘Å’ ÃÂºÃÂ»Ã‘Å½Ã‘â€¡';
      _G.fluxus_ui_values["key_copied"] = ' Ãâ€ÃÂ¾ÃÂ±Ã‘â‚¬ÃÂ¾ ÃÂ¿ÃÂ¾ÃÂ¶ÃÂ°ÃÂ»ÃÂ¾ÃÂ²ÃÂ°Ã‘â€šÃ‘Å’ ÃÂ² Fluxus Android!<br/>ÃÂ¡Ã‘ÂÃ‘â€¹ÃÂ»ÃÂºÃÂ° ÃÂ½ÃÂ° ÃÂºÃÂ»Ã‘Å½Ã‘â€¡ ÃÂ±Ã‘â€¹ÃÂ»ÃÂ° Ã‘ÂÃÂºÃÂ¾ÃÂ¿ÃÂ¸Ã‘â‚¬ÃÂ¾ÃÂ²ÃÂ°ÃÂ½ÃÂ° ÃÂ² ÃÂ±Ã‘Æ’Ã‘â€žÃÂµÃ‘â‚¬ ÃÂ¾ÃÂ±ÃÂ¼ÃÂµÃÂ½ÃÂ°. ÃÅ¸ÃÂ¾ÃÂ¶ÃÂ°ÃÂ»Ã‘Æ’ÃÂ¹Ã‘ÂÃ‘â€šÃÂ°, ÃÂ¾Ã‘â€šÃÂºÃ‘â‚¬ÃÂ¾ÃÂ¹Ã‘â€šÃÂµ ÃÂµÃÂµ ÃÂ² ÃÂ±Ã‘â‚¬ÃÂ°Ã‘Æ’ÃÂ·ÃÂµÃ‘â‚¬ÃÂµ.<br/>ÃÂÃ‘Æ’ÃÂ¶ÃÂ½ÃÂ° ÃÂ¿ÃÂ¾ÃÂ¼ÃÂ¾Ã‘â€°Ã‘Å’? ÃÅ¸Ã‘â‚¬ÃÂ¸Ã‘ÂÃÂ¾ÃÂµÃÂ´ÃÂ¸ÃÂ½Ã‘ÂÃÂ¹Ã‘â€šÃÂµÃ‘ÂÃ‘Å’ ÃÂº discord.gg/'; 
      
      _G.fluxus_ui_values["welcome_text"] = '<font size="24">Ãâ€”ÃÂ´Ã‘â‚¬ÃÂ°ÃÂ²Ã‘ÂÃ‘â€šÃÂ²Ã‘Æ’ÃÂ¹Ã‘â€šÃÂµ ÃÂ¸ ÃÂ´ÃÂ¾ÃÂ±Ã‘â‚¬ÃÂ¾ ÃÂ¿ÃÂ¾ÃÂ¶ÃÂ°ÃÂ»ÃÂ¾ÃÂ²ÃÂ°Ã‘â€šÃ‘Å’ ÃÂ² Fluxus Android!</font><br/>Ãâ€™ÃÂ²ÃÂµÃÂ´ÃÂ¸Ã‘â€šÃÂµ Ã‘ÂÃÂ²ÃÂ¾ÃÂ¹ Ã‘ÂÃÂºÃ‘â‚¬ÃÂ¸ÃÂ¿Ã‘â€š ÃÂ¸ÃÂ»ÃÂ¸ ÃÂ¸Ã‘ÂÃÂ¿ÃÂ¾ÃÂ»Ã‘Å’ÃÂ·Ã‘Æ’ÃÂ¹Ã‘â€šÃÂµ ÃÂ²ÃÂºÃÂ»ÃÂ°ÃÂ´ÃÂºÃ‘Æ’ ÃÂ¸ÃÂ³Ã‘â‚¬ ÃÂ½ÃÂ° the left';
      _G.fluxus_ui_values["execute_from_textbox"] = 'Ãâ€™Ã‘â€¹ÃÂ¿ÃÂ¾ÃÂ»ÃÂ½ÃÂ¸Ã‘â€šÃ‘Å’ ÃÂ¸ÃÂ· Ã‘â€šÃÂµÃÂºÃ‘ÂÃ‘â€šÃÂ¾ÃÂ²ÃÂ¾ÃÂ³ÃÂ¾ ÃÂ¿ÃÂ¾ÃÂ»Ã‘Â';
      _G.fluxus_ui_values["execute_from_clipboard"] = 'Ãâ€™Ã‘â€¹ÃÂ¿ÃÂ¾ÃÂ»ÃÂ½ÃÂ¸Ã‘â€šÃ‘Å’ ÃÂ¸ÃÂ· ÃÂ±Ã‘Æ’Ã‘â€žÃÂµÃ‘â‚¬ÃÂ° ÃÂ¾ÃÂ±ÃÂ¼ÃÂµÃÂ½ÃÂ°'; 
      _G.fluxus_ui_values["credits"] = 'Fluxus Android, Ã‘ÂÃÂ¾ÃÂ·ÃÂ´ÃÂ°ÃÂ½ÃÂ½Ã‘â€¹ÃÂ¹:<br/>- ShowerHeadFD<br/> - Rev<br/>- YieldingExploiter<br/><br/><i>Ãâ€™ÃÂºÃÂ»ÃÂ°ÃÂ´ÃÂºÃÂ° "ÃÂ¡ÃÂºÃ‘â‚¬ÃÂ¸ÃÂ¿Ã‘â€šÃ‘â€¹" ÃÂ¾Ã‘â€š Scriptblox.com</i><br/>ÃÅ¸ÃÂ¾ÃÂ´Ã‘â‚¬ÃÂ¾ÃÂ±ÃÂ½ÃÂµÃÂµ ÃÂ¾ ÃÂ¿Ã‘â‚¬ÃÂ¾ÃÂ´Ã‘Æ’ÃÂºÃ‘â€šÃÂ°Ã‘â€¦ ÃÂ½ÃÂ° <i>flux.li</i>'; 
      
      _G.fluxus_ui_values["submit_query"] = 'ÃÅ¾Ã‘â€šÃÂ¿Ã‘â‚¬ÃÂ°ÃÂ²ÃÂ¸Ã‘â€šÃ‘Å’';
      _G.fluxus_ui_values["search_query_text"] = 'ÃÅ¸ÃÂ¾ÃÂ¸Ã‘ÂÃÂºÃÂ¾ÃÂ²Ã‘â€¹ÃÂ¹ ÃÂ·ÃÂ°ÃÂ¿Ã‘â‚¬ÃÂ¾Ã‘Â | Powered by scriptblox.com'; 
      
      _G.fluxus_ui_values["small_ui"] = 'ÃÅ“ÃÂ°ÃÂ»ÃÂµÃÂ½Ã‘Å’ÃÂºÃÂ¸ÃÂ¹ ÃÂ¿ÃÂ¾ÃÂ»Ã‘Å’ÃÂ·ÃÂ¾ÃÂ²ÃÂ°Ã‘â€šÃÂµÃÂ»Ã‘Å’Ã‘ÂÃÂºÃÂ¸ÃÂ¹ ÃÂ¸ÃÂ½Ã‘â€šÃÂµÃ‘â‚¬Ã‘â€žÃÂµÃÂ¹Ã‘Â'; 
      _G.fluxus_ui_values["centeredminimize"] = 'ÃËœÃ‘ÂÃÂ¿ÃÂ¾ÃÂ»Ã‘Å’ÃÂ·ÃÂ¾ÃÂ²ÃÂ°Ã‘â€šÃ‘Å’ Ã‘ÂÃÂ²ÃÂµÃ‘â‚¬Ã‘â€šÃ‘â€¹ÃÂ²ÃÂ°ÃÂ½ÃÂ¸ÃÂµ ÃÂ¿ÃÂ¾ Ã‘â€ ÃÂµÃÂ½Ã‘â€šÃ‘â‚¬Ã‘Æ’'; 
      _G.fluxus_ui_values["tabimages"] = 'ÃÅ¸ÃÂ¾ÃÂºÃÂ°ÃÂ·ÃÂ°Ã‘â€šÃ‘Å’ ÃÂ¸ÃÂ·ÃÂ¾ÃÂ±Ã‘â‚¬ÃÂ°ÃÂ¶ÃÂµÃÂ½ÃÂ¸Ã‘Â ÃÂ²ÃÂºÃÂ»ÃÂ°ÃÂ´ÃÂ¾ÃÂº'; 
      _G.fluxus_ui_values["noautoexec"] = 'ÃËœÃÂ³ÃÂ½ÃÂ¾Ã‘â‚¬ÃÂ¸Ã‘â‚¬ÃÂ¾ÃÂ²ÃÂ°Ã‘â€šÃ‘Å’ Autoexec'; 
      _G.fluxus_ui_values["clearautoexec"] = 'ÃÅ¾Ã‘â€¡ÃÂ¸Ã‘ÂÃ‘â€šÃÂ¸Ã‘â€šÃ‘Å’ Autoexec'; 
      _G.fluxus_ui_values["fastanim"] = 'Ãâ€˜Ã‘â€¹Ã‘ÂÃ‘â€šÃ‘â‚¬ÃÂ°Ã‘Â ÃÂ°ÃÂ½ÃÂ¸ÃÂ¼ÃÂ°Ã‘â€ ÃÂ¸Ã‘Â'; 
      _G.fluxus_ui_values["noanim"] = 'Ãâ€˜ÃÂµÃÂ· ÃÂ°ÃÂ½ÃÂ¸ÃÂ¼ÃÂ°Ã‘â€ ÃÂ¸ÃÂ¸'; 
      _G.fluxus_ui_values["scripthistory"] = 'ÃËœÃ‘ÂÃ‘â€šÃÂ¾Ã‘â‚¬ÃÂ¸Ã‘Â Ã‘ÂÃ‘â€ ÃÂµÃÂ½ÃÂ°Ã‘â‚¬ÃÂ¸ÃÂµÃÂ²'; 
      _G.fluxus_ui_values["purchaseprotections"] = 'ÐŸÐµÑ€ÐµÐºÐ»ÑŽÑ‡ÐµÐ½Ð¸Ðµ Ð·Ð°Ñ‰Ð¸Ñ‚Ñ‹ Ð¿Ð¾ÐºÑƒÐ¿Ð¾Ðº';
    elseif code == "HR" then
      _G.fluxus_ui_values["key_instructions"] = 'DobrodoÃ…Â¡li u Fluxus Android!<br/>Molim vas kliknite \'Dobij kljuÃ„Â\' da dobite kljuÃ„Â.<br/>Kada\ zavrÃ…Â¡ite system za kljuÃ„Â, upiÃ…Â¡ite kljuÃ„Â ispod, onda kliknite \'Provjeri KljuÃ„Â\'';
      _G.fluxus_ui_values["key_paste_key_here"] = 'Zaljepi svoj kljuÃ„Â ovdje';
      _G.fluxus_ui_values["key_get_key"] = 'Dobi kljuÃ„Â';
      _G.fluxus_ui_values["key_check_key"] = 'Provjeri kljuÃ„Â';
      _G.fluxus_ui_values["key_copied"] = 'DobrodoÃ…Â¡li u Fluxus Android!<br/>Link za kljuÃ„Â je bio kopiran - Molim vas ga otvorite u pregledniku.<br/>Trebate pomoÃ„â€¡? Join discord.gg/';
        
      _G.fluxus_ui_values["welcome_text"] = '<font size="24">Bok i dobrodoÃ…Â¡li u Fluxus Android!</font><br/>UpiÃ…Â¡ite svoju skriptu ili koristite tab za igrice na lijevoj strani';
      _G.fluxus_ui_values["execute_from_textbox"] = 'Execute from Textbox';
      _G.fluxus_ui_values["execute_from_clipboard"] = 'Execute from Clipboard';
      _G.fluxus_ui_values["credits"] = 'Fluxus Android je napravljen od:<br/>- ShowerHeadFD<br/>- Rev<br/>- YieldingExploiter<br/><br/><i>Tab za skripte omoguÃ„Âen od Scriptblox.com</i><br/>IstraÃ…Â¾ite viÃ…Â¡e proizvoda kod <i>flux.li</i>';
        
      _G.fluxus_ui_values["submit_query"] = 'PoÃ…Â¡alji';
      _G.fluxus_ui_values["search_query_text"] = 'PretraÃ…Â¾i | OmoguÃ„Âeno od scriptblox.com';
          
      _G.fluxus_ui_values["small_ui"] = 'Mali UI';
      _G.fluxus_ui_values["centeredminimize"] = 'Koristi Centered Minimize';  
      _G.fluxus_ui_values["tabimages"] = 'PokaÃ…Â¾i slike na tabovima';
      _G.fluxus_ui_values["noautoexec"] = 'Ignoriraj Autoexec';
      _G.fluxus_ui_values["clearautoexec"] = 'IzbriÃ…Â¡i Autoexec';
      _G.fluxus_ui_values["fastanim"] = 'Brze animacije';
      _G.fluxus_ui_values["noanim"] = 'Makni animacije';
      _G.fluxus_ui_values["scripthistory"] = 'Povijest skripta';
      _G.fluxus_ui_values["purchaseprotections"] = 'UkljuÄite zaÅ¡titu kupnje';
    elseif code == "NL" then
      _G.fluxus_ui_values["key_instructions"] = 'Welkom bij Fluxus Android!<br/>Klik op \'Sleutel ophalen\' om een sleutel te krijgen.<br/>Zodra u het sleutelsysteem heeft voltooid, voert u hieronder uw sleutel in en klikt u op  \'Controle sleutel\'';
      _G.fluxus_ui_values["key_paste_key_here"] = 'Plak hier uw sleutel';
      _G.fluxus_ui_values["key_get_key"] = 'Sleutel ophalen';
      _G.fluxus_ui_values["key_check_key"] = 'Sleutel controleren';
      _G.fluxus_ui_values["key_copied"] = 'Welkom bij Fluxus Android!<br/>De sleutellink is naar uw klembord gekopieerd - open deze in een browser.<br/>Hulp nodig?  Word lid van discord.gg/';
      
      _G.fluxus_ui_values["welcome_text"] = '<font size="24">Hallo en welkom bij Fluxus Android!</font><br/>Voer je script in of gebruik het tabblad Games aan de linkerkant';
      _G.fluxus_ui_values["execute_from_textbox"] = 'Uitvoeren vanuit tekstvak';
      _G.fluxus_ui_values["execute_from_clipboard"] = 'Uitvoeren vanaf klembord';
      _G.fluxus_ui_values["credits"] = 'Fluxus Android gemaakt door:<br/>- ShowerHeadFD<br/>- Rev<br/>- YieldingExploiter<br/><br/><i>Tabblad Scripts mogelijk gemaakt door Scriptblox.com</  i><br/>Ontdek meer producten op <i>flux.li</i>';
      
      _G.fluxus_ui_values["submit_query"] = 'Verzenden';
      _G.fluxus_ui_values["search_query_text"] = 'Zoekopdracht |  Mogelijk gemaakt door scriptblox.com';
        
      _G.fluxus_ui_values["small_ui"] = 'Kleine gebruikersinterface';
      _G.fluxus_ui_values["centeredminimize"] = 'Gebruik gecentreerd minimaliseren';
      _G.fluxus_ui_values["tabimages"] = 'Tabbladafbeeldingen tonen';
      _G.fluxus_ui_values["noautoexec"] = 'Negeer Autoexec';
      _G.fluxus_ui_values["clearautoexec"] = 'Autoexec wissen';
      _G.fluxus_ui_values["fastanim"] = 'Snelle animaties';
      _G.fluxus_ui_values["noanim"] = 'Geen animaties';
      _G.fluxus_ui_values["scripthistory"] = 'Scriptgeschiedenis';
      _G.fluxus_ui_values["purchaseprotections"] = 'Aankoopbeveiliging in-/uitschakelen';
    elseif code == "VN" then
      _G.fluxus_ui_values["key_instructions"] = 'ChÃƒ o mÃ¡Â»Â«ng Ã„â€˜Ã¡ÂºÂ¿n Fluxus trÃƒÂªn Android!<br/>Xin hÃƒÂ£y nhÃ¡ÂºÂ¥n\'LÃ¡ÂºÂ¥y Key\' Ã„ÂÃ¡Â»Æ’ lÃ¡ÂºÂ¥y key.<br/>Khi bÃ¡ÂºÂ¡n\ Ã„â€˜ÃƒÂ£ lÃƒ m xong thÃƒÂ¬ nhÃ¡ÂºÂ­p key cÃ¡Â»Â§a bÃ¡ÂºÂ¡n Ã¡Â»Å¸ dÃ†Â°Ã¡Â»â€ºi, rÃ¡Â»â€œi nhÃ¡ÂºÂ¥n \'KiÃ¡Â»Æ’m tra key \'';
      _G.fluxus_ui_values["key_paste_key_here"] = 'DÃƒÂ¡n key cÃ¡Â»Â§a bÃ¡ÂºÂ¡n Ã¡Â»Å¸ Ã„â€˜ÃƒÂ¢y';
      _G.fluxus_ui_values["key_get_key"] = 'LÃ¡ÂºÂ¥y Key';
      _G.fluxus_ui_values["key_check_key"] = 'KiÃ¡Â»Æ’m tra Key';
      _G.fluxus_ui_values["key_copied"] = 'ChÃƒ o mÃ¡Â»Â«ng Ã„â€˜Ã¡ÂºÂ¿n Fluxus trÃƒÂªn Android!<br/>Link key Ã„â€˜ÃƒÂ£ Ã„â€˜Ã†Â°Ã¡Â»Â£c sao chÃƒÂ©p - Vui lÃƒÂ²ng dÃƒÂ¡n trÃƒÂªn trÃƒÂ¬nh duyÃ¡Â»â€¡t cÃ¡Â»Â§a bÃ¡ÂºÂ¡n.<br/>CÃ¡ÂºÂ§n giÃƒÂºp Ã„â€˜Ã¡Â»Â¡?? VÃƒ o server discord.gg/';
        
      _G.fluxus_ui_values["welcome_text"] = '<font size="24">Xin chÃƒ o vÃƒ  chÃƒ o mÃ¡Â»Â«ng Ã„â€˜Ã¡ÂºÂ¿n Fluxus trÃƒÂªn Android</font><br/>NhÃ¡ÂºÂ­p mÃƒÂ£ cÃ¡Â»Â§a bÃ¡ÂºÂ¡n hay lÃƒ  xÃ¡Â»Â­ dÃ¡Â»Â¥ng game tab Ã¡Â»Å¸ phÃƒÂ­a bÃƒÂªn trÃƒÂ¡i';
      _G.fluxus_ui_values["execute_from_textbox"] = 'Execute tÃ¡Â»Â« Textbox';
      _G.fluxus_ui_values["execute_from_clipboard"] = 'Execute tÃ¡Â»Â« Clipboard';
      _G.fluxus_ui_values["credits"] = 'Fluxus Android Ã„â€˜Ã†Â°Ã¡Â»Â£c lÃƒ m bÃ¡Â»Å¸:<br/>- ShowerHeadFD<br/>- Rev<br/>- YieldingExploiter<br/><br/><i>Scripts tab Ã„â€˜Ã†Â°Ã¡Â»Â£c hÃ¡Â»â€” trÃ¡Â»Â£ tÃ¡Â»Â« Scriptblox.com</i><br/>TÃƒÂ¬m hiÃ¡Â»Æ’u thÃƒÂªm nhiÃ¡Â»Âu sÃ¡ÂºÂ£n phÃ¡ÂºÂ©m Ã¡Â»Å¸ <i>flux.li</i>';
        
      _G.fluxus_ui_values["submit_query"] = 'GÃ¡Â»Â­i';
      _G.fluxus_ui_values["search_query_text"] = 'TÃƒÂ¬m kiÃ¡ÂºÂ¿m| tÃ¡Â»Â« scriptblox.com';
          
      _G.fluxus_ui_values["small_ui"] = 'UI nhÃ¡Â»Â';
      _G.fluxus_ui_values["centeredminimize"] = 'SÃ¡Â»Â­ dÃ¡Â»Â¥ng Thu nhÃ¡Â»Â CÃ„Æ’n giÃ¡Â»Â¯a';  
      _G.fluxus_ui_values["tabimages"] = 'HiÃ¡Â»Æ’n thÃ¡Â»â€¹ hÃƒÂ¬nh Ã¡ÂºÂ£nh thÃ¡ÂºÂ»';
      _G.fluxus_ui_values["noautoexec"] = 'BÃ¡Â»Â qua autoexecute';
      _G.fluxus_ui_values["clearautoexec"] = 'XoÃƒÂ¡ autoexecute';
      _G.fluxus_ui_values["fastanim"] = 'Ã¡ÂºÂ¢nh Ã„â€˜Ã¡Â»â„¢ng nhanh';
      _G.fluxus_ui_values["noanim"] = 'KhÃƒÂ´ng Ã¡ÂºÂ£nh Ã„â€˜Ã¡Â»â„¢ng';
      _G.fluxus_ui_values["scripthistory"] = 'LÃ¡Â»â€¹ch sÃ¡Â»Â­ script';
      _G.fluxus_ui_values["purchaseprotections"] = 'Toggle Báº£o vá»‡ mua hÃ ng';
    elseif code == "TR" then
      _G.fluxus_ui_values["key_instructions"] = 'Fluxus Android\'e hoÃ…Å¸geldiniz!<br/>Anahtar almak iÃƒÂ§in \'Anahtar Al\' butonuna tÃ„Â±klayÃ„Â±n.<br/>anahtar sistemini tamamladÃ„Â±ktan sonra, anahtarÃ„Â±nÃ„Â±zÃ„Â± aÃ…Å¸aÃ„Å¸Ã„Â±ya girin, daha sonra \'AnahtarÃ„Â± Kontrol Et\' butonuna tÃ„Â±klayÃ„Â±n.';
      _G.fluxus_ui_values["key_paste_key_here"] = 'AnahtarÃ„Â±nÃ„Â±zÃ„Â± buraya yapÃ„Â±Ã…Å¸tÃ„Â±rÃ„Â±n';
      _G.fluxus_ui_values["key_get_key"] = 'Anahtar Al';
      _G.fluxus_ui_values["key_check_key"] = 'AnahtarÃ„Â± Kontrol Et';
      _G.fluxus_ui_values["key_copied"] = 'Fluxus Android\'e hoÃ…Å¸geldiniz!<br/>Anahtar linki panonuza kopyalandÃ„Â±. LÃƒÂ¼tfen bir tarayÃ„Â±cÃ„Â±da aÃƒÂ§Ã„Â±n.<br/>YardÃ„Â±ma mÃ„Â± ihtiyacÃ„Â±nÃ„Â±z var? discord.gg/';

      _G.fluxus_ui_values["welcome_text"] = '<font size="24">Merhaba, Fluxus Android\'e hoÃ…Å¸geldiniz</font><br/>Komut dosyanÃ„Â±zÃ„Â± girin veya soldaki oyunlar sekmesini kullanÃ„Â±n';
      _G.fluxus_ui_values["execute_from_textbox"] = 'Metin Kutusundan Execute et';
      _G.fluxus_ui_values["execute_from_clipboard"] = 'Panodan Execute et';
      _G.fluxus_ui_values["credits"] = 'Fluxus android:<br/>- ShowerHeadFD<br/>- Rev<br/>- YieldingExploiter<br/><br/><i> tarafÃ„Â±ndan yapÃ„Â±ldÃ„Â±. Scriptler sekmesi Scriptblox.com tarafÃ„Â±ndan saÃ„Å¸landÃ„Â±.</i><br/>Daha fazla ÃƒÂ¼rÃƒÂ¼n iÃƒÂ§in <i>flux.li</i>';

      _G.fluxus_ui_values["submit_query"] = 'GÃƒÂ¶nder';
      _G.fluxus_ui_values["search_query_text"] = 'Arama Butonu | scriptblox.com tarafÃ„Â±ndan saÃ„Å¸landÃ„Â±';
      
      _G.fluxus_ui_values["small_ui"] = 'KÃƒÂ¼ÃƒÂ§ÃƒÂ¼k UI';
      _G.fluxus_ui_values["centeredminimize"] = 'OrtalanmÃ„Â±Ã…Å¸ KÃƒÂ¼ÃƒÂ§ÃƒÂ¼ltmeyi Kullan';  
      _G.fluxus_ui_values["tabimages"] = 'Sekme Resimlerini GÃƒÂ¶ster';
      _G.fluxus_ui_values["noautoexec"] = 'Autoexeci gÃƒÂ¶rmezden gel';
      _G.fluxus_ui_values["clearautoexec"] = 'Autoexeci temizle';
      _G.fluxus_ui_values["fastanim"] = 'HÃ„Â±zlÃ„Â± Animasyonlar';
      _G.fluxus_ui_values["noanim"] = 'Animasyon Yok';
      _G.fluxus_ui_values["scripthistory"] = 'Script GeÃƒÂ§miÃ…Å¸i';
      _G.fluxus_ui_values["purchaseprotections"] = 'SatÄ±n Alma KorumalarÄ±nÄ± AÃ§/Kapat';
    elseif code == "RO" then
      _G.fluxus_ui_values["key_instructions"] = 'Bun venit la Fluxus Android!<br/>Te rog apasa \'Obtine cheie\' pentru a obtine o cheie.<br/>O data ce ati finalizat sistemul de cheie, introduceti cheia mai jos, si apasati \'Verificare cheie\'';
      _G.fluxus_ui_values["key_paste_key_here"] = 'Lipiti-va cheia aici!';
      _G.fluxus_ui_values["key_get_key"] = 'Obtine cheie';
      _G.fluxus_ui_values["key_check_key"] = 'Verifica cheie';
      _G.fluxus_ui_values["key_copied"] = 'Bun venit la Fluxus Android!<br/>Linkul cheii a fost copiat in clipboard - Va rugam sa il deschideti intr-un browser.<br/>Nevoie de ajutor? Intrati in discord.gg/';

      _G.fluxus_ui_values["welcome_text"] = '<font size="24">Salut si bun venit la Fluxus Android!</font><br/>Introduceti scriptul sau folositi fila de jocuri din stanga';
      _G.fluxus_ui_values["execute_from_textbox"] = 'Executati din Textbox';
      _G.fluxus_ui_values["execute_from_clipboard"] = 'Executati din Clipboard';
      _G.fluxus_ui_values["credits"] = 'Fluxus Android facut de:<br/>- ShowerHeadFD<br/>- Rev<br/>- YieldingExploiter<br/><br/><i>Fila scripturi oferita de Scriptblox.com</i><br/>Descoperiti mai multe produse la <i>flux.li</i>';

      _G.fluxus_ui_values["submit_query"] = 'Trimite';
      _G.fluxus_ui_values["search_query_text"] = 'Interogare de cautare | Produs de scriptblox.com';
      
      _G.fluxus_ui_values["small_ui"] = 'UI Mic';
      _G.fluxus_ui_values["centeredminimize"] = 'Utilizati Minimizarea centrata';  
      _G.fluxus_ui_values["tabimages"] = 'Afisati imaginile filelor';
      _G.fluxus_ui_values["noautoexec"] = 'Ignora Autoexec';
      _G.fluxus_ui_values["clearautoexec"] = 'Sterge Autoexec';
      _G.fluxus_ui_values["fastanim"] = 'Animatii rapide';
      _G.fluxus_ui_values["noanim"] = 'Fara animatii';
      _G.fluxus_ui_values["scripthistory"] = 'Istoricul scripturilor';
      _G.fluxus_ui_values["purchaseprotections"] = 'Comutare protecÈ›ii de achiziÈ›ie';
    elseif code == "DE" then
      _G.fluxus_ui_values["key_instructions"] = 'Willkommen bei Fluxus Andriod!<br/>Bitte klick auf \'SchlÃƒÂ¼ssel bekommen\' um den SchlÃƒÂ¼ssel zu bekommen.<br/>Wenn du den SchlÃƒÂ¼ssel hast, kopiere dein SchlÃƒÂ¼ssel in das KÃƒÂ¤stchen, dann klick auf \'SchlÃƒÂ¼ssel ÃƒÂ¼berprÃƒÂ¼fen\'';
      _G.fluxus_ui_values["key_paste_key_here"] = 'SchlÃƒÂ¼ssel hier reinkopieren';
      _G.fluxus_ui_values["key_get_key"] = 'SchlÃƒÂ¼ssel bekommen';
      _G.fluxus_ui_values["key_check_key"] = 'SchlÃƒÂ¼ssel ÃƒÂ¼berprÃƒÂ¼fen';
      _G.fluxus_ui_values["key_copied"] = 'Willkommen bei Fluxus Andriod!<br/>Der Link wurde in deine Zwischenablage kopiert - Bitte ÃƒÂ¶ffne den link im Browser.<br/>Brauchst du hilfe? Werde jetzt Mitglied discord.gg/';
        
      _G.fluxus_ui_values["welcome_text"] = '<font size="24">Hallo und Willkommen bei Fluxus Adroid!</font><br/>Gebe dein Skript ein oder verwenden die Registerkarte auf der linken Seite';
      _G.fluxus_ui_values["execute_from_textbox"] = 'AusfÃƒÂ¼hren aus der Textbox';
      _G.fluxus_ui_values["execute_from_clipboard"] = 'AusfÃƒÂ¼hren von der Textbox';
      _G.fluxus_ui_values["credits"] = 'Fluxus Andriod erstellt von:<br/>- ShowerHeadFD<br/>- Rev<br/>- YieldingExploiter<br/><br/><i>Scripts Registerkarte powered by Scriptblox.com</i><br/>Entdecke mehr Produkte bei <i>flux.li</i>';
        
      _G.fluxus_ui_values["submit_query"] = 'Einreichen';
      _G.fluxus_ui_values["search_query_text"] = 'Suchabfrage | Powered by scriptblox.com';
          
      _G.fluxus_ui_values["small_ui"] = 'Kleine UI';
      _G.fluxus_ui_values["centeredminimize"] = 'Zentriertes Minimieren verwenden';  
      _G.fluxus_ui_values["tabimages"] = 'Zeige Registerkarten Bilder';
      _G.fluxus_ui_values["noautoexec"] = 'Ignoriere Autoexec';
      _G.fluxus_ui_values["clearautoexec"] = 'LÃƒÂ¶sche Autoexec';
      _G.fluxus_ui_values["fastanim"] = 'Schnelle Animationen';
      _G.fluxus_ui_values["noanim"] = 'Keine Animationen';
      _G.fluxus_ui_values["scripthistory"] = 'Script Geschichte';
      _G.fluxus_ui_values["purchaseprotections"] = 'Deaktivieren des KÃ¤uferschutzes';
    end
end

function hex2rgb(hex)
	hex = hex:gsub("#","")
	local r = tonumber("0x"..hex:sub(1,2))
	local g = tonumber("0x"..hex:sub(3,4))
	local b = tonumber("0x"..hex:sub(5,6))
	return Color3.fromRGB(r,g,b)
end

pcall(function()
  if isfile("theme.flux") then
    local data = readfile("theme.flux")
    local json_data = game:GetService("HttpService"):JSONDecode(data)
    
    if(json_data["main_grid"]) then
      local img = json_data["main_grid"];

      if(img:find("https")) then
        local url_hash = crypt.hash(img)..".png";
        if(not isfile(url_hash)) then
          writefile(url_hash, request({Url = img}).Body)
        end

        if(getcustomasset) then
          Global_Image = getcustomasset(url_hash)
        end
      elseif(isfile(img)) then
        Global_Image = getcustomasset(img)
      elseif(img:find("#")) then
        Global_Image = hex2rgb(img)
      end
    end

    if(json_data["background_image"]) then
      local img = json_data["background_image"];

      if(img:find("https")) then
        local url_hash = crypt.hash(img)..".png";
        if(not isfile(url_hash)) then
          writefile(url_hash, request({Url = img}).Body)
        end

        if(getcustomasset) then
          Global_Image = getcustomasset(url_hash)
        end
      elseif(isfile(img)) then
        Global_Image = getcustomasset(img)
      elseif(img:find("#")) then
        Global_Image = hex2rgb(img)
      end
    end

    if(json_data["button_color"]) then
      local clr = json_data["button_color"];

      if(clr:find("#")) then
        Global_Button_Color = hex2rgb(clr)
      end
    end

    if(json_data["text_color"]) then
      local clr = json_data["text_color"];
      
      if(clr:find("#")) then
        Global_Text_Color = hex2rgb(clr)
      end
    end

    if(json_data["tabs_color"]) then
      local clr = json_data["tabs_color"];
      
      if(clr:find("#")) then
        Global_Tabs_Color = hex2rgb(clr)
      end
    end

    if(json_data["editor_color"]) then
      local clr = json_data["editor_color"];
      
      if(clr:find("#")) then
        if(clr == "#") then
          Global_Editor_Transparent = true;
        end
        Global_Editor_Color = hex2rgb(clr)
      end
    end

  end
end)

local UIElem = {}

local function CreateInc(name, class)
    local Characters = "UI_" .. math.random(100000, 999999)
    local element = Instance.new(class)
    UIElem[name] = element
    return element
end

local FluxusAndroidUI = CreateInc("FluxusAndroidUI", "ScreenGui")
local Container = CreateInc("Container", "Frame")
local Loader = CreateInc("Loader", "Frame")
local UIAspectRatioConstraint = CreateInc("UIAspectRatioConstraint", "UIAspectRatioConstraint")
local Border = CreateInc("Border", "Frame")
local UICorner = CreateInc("UICorner", "UICorner")
local UICorner_2 = CreateInc("UICorner_2", "UICorner")
local Icon = CreateInc("Icon", "ImageLabel")
local UIAspectRatioConstraint_2 = CreateInc("UIAspectRatioConstraint_2", "UIAspectRatioConstraint")
local Key = CreateInc("Key", "Frame")
local UIAspectRatioConstraint_3 = CreateInc("UIAspectRatioConstraint_3", "UIAspectRatioConstraint")
local Border_2 = CreateInc("Border_2", "Frame")
local UICorner_3 = CreateInc("UICorner_3", "UICorner")
local UICorner_4 = CreateInc("UICorner_4", "UICorner")
local Icon_2 = CreateInc("Icon_2", "ImageLabel")
local UIAspectRatioConstraint_4 = CreateInc("UIAspectRatioConstraint_4", "UIAspectRatioConstraint")
local Container_2 = CreateInc("Container_2", "Frame")
local UICorner_5 = CreateInc("UICorner_5", "UICorner")
local CheckKey = CreateInc("CheckKey", "TextButton")
local UICorner_6 = CreateInc("UICorner_6", "UICorner")
local TextLabel = CreateInc("TextLabel", "TextLabel")
local GetKey = CreateInc("GetKey", "TextButton")
local UICorner_7 = CreateInc("UICorner_7", "UICorner")
local TextLabel_2 = CreateInc("TextLabel_2", "TextLabel")
local KeyContainer = CreateInc("KeyContainer", "TextLabel")
local UICorner_8 = CreateInc("UICorner_8", "UICorner")
local Instructions = CreateInc("Instructions", "TextLabel")
local KeyBox = CreateInc("KeyBox", "TextBox")
local minimizeContainer = CreateInc("minimizeContainer", "Frame")
local UICorner_9 = CreateInc("UICorner_9", "UICorner")
local _1Minimize = CreateInc("_1Minimize", "ImageButton")
local UIAspectRatioConstraint_5 = CreateInc("UIAspectRatioConstraint_5", "UIAspectRatioConstraint")
local UIAspectRatioConstraint_6 = CreateInc("UIAspectRatioConstraint_6", "UIAspectRatioConstraint")
local TransitionUI = CreateInc("TransitionUI", "Frame")
local Border_3 = CreateInc("Border_3", "Frame")
local UICorner_10 = CreateInc("UICorner_10", "UICorner")
local UICorner_11 = CreateInc("UICorner_11", "UICorner")
local MainUI = CreateInc("MainUI", "ImageLabel")
local Border_4 = CreateInc("Border_4", "Frame")
local UICorner_12 = CreateInc("UICorner_12", "UICorner")
local UICorner_13 = CreateInc("UICorner_13", "UICorner")
local Tabs = CreateInc("Tabs", "Frame")
local Scroller = CreateInc("Scroller", "ScrollingFrame")
local UIListLayout = CreateInc("UIListLayout", "UIListLayout")
local Btn = CreateInc("Btn", "ImageButton")
local UIAspectRatioConstraint_7 = CreateInc("UIAspectRatioConstraint_7", "UIAspectRatioConstraint")
local UICorner_14 = CreateInc("UICorner_14", "UICorner")
local UICorner_15 = CreateInc("UICorner_15", "UICorner")
local _1Minimize_2 = CreateInc("_1Minimize_2", "ImageButton")
local UIAspectRatioConstraint_8 = CreateInc("UIAspectRatioConstraint_8", "UIAspectRatioConstraint")
local UIListLayout_2 = CreateInc("UIListLayout_2", "UIListLayout")
local Content = CreateInc("Content", "ScrollingFrame")
local UIListLayout_3 = CreateInc("UIListLayout_3", "UIListLayout")
local Spacer = CreateInc("Spacer", "Frame")
local Text = CreateInc("Text", "Frame")
local Label = CreateInc("Label", "TextLabel")
local Button = CreateInc("Button", "Frame")
local WithText = CreateInc("WithText", "Frame")
local ActiveButton = CreateInc("ActiveButton", "TextButton")
local UIAspectRatioConstraint_9 = CreateInc("UIAspectRatioConstraint_9", "UIAspectRatioConstraint")
local UITextSizeConstraint = CreateInc("UITextSizeConstraint", "UITextSizeConstraint")
local UICorner_16 = CreateInc("UICorner_16", "UICorner")
local Label_2 = CreateInc("Label_2", "TextLabel")
local PassiveButton = CreateInc("PassiveButton", "TextButton")
local UIAspectRatioConstraint_10 = CreateInc("UIAspectRatioConstraint_10", "UIAspectRatioConstraint")
local UITextSizeConstraint_2 = CreateInc("UITextSizeConstraint_2", "UITextSizeConstraint")
local UICorner_17 = CreateInc("UICorner_17", "UICorner")
local NoText = CreateInc("NoText", "Frame")
local ActiveButton_2 = CreateInc("ActiveButton_2", "TextButton")
local UITextSizeConstraint_3 = CreateInc("UITextSizeConstraint_3", "UITextSizeConstraint")
local UICorner_18 = CreateInc("UICorner_18", "UICorner")
local TextLabel_3 = CreateInc("TextLabel_3", "TextLabel")
local PassiveButton_2 = CreateInc("PassiveButton_2", "TextButton")
local UITextSizeConstraint_4 = CreateInc("UITextSizeConstraint_4", "UITextSizeConstraint")
local UICorner_19 = CreateInc("UICorner_19", "UICorner")
local TextLabel_4 = CreateInc("TextLabel_4", "TextLabel")
local Checkbox = CreateInc("Checkbox", "Frame")
local Checked = CreateInc("Checked", "TextButton")
local UIAspectRatioConstraint_11 = CreateInc("UIAspectRatioConstraint_11", "UIAspectRatioConstraint")
local UITextSizeConstraint_5 = CreateInc("UITextSizeConstraint_5", "UITextSizeConstraint")
local UICorner_20 = CreateInc("UICorner_20", "UICorner")
local Unchecked = CreateInc("Unchecked", "TextButton")
local UIAspectRatioConstraint_12 = CreateInc("UIAspectRatioConstraint_12", "UIAspectRatioConstraint")
local UITextSizeConstraint_6 = CreateInc("UITextSizeConstraint_6", "UITextSizeConstraint")
local UICorner_21 = CreateInc("UICorner_21", "UICorner")
local Label_3 = CreateInc("Label_3", "TextLabel")
local Textbox = CreateInc("Textbox", "Frame")
local TextBox = CreateInc("TextBox", "TextBox")
local UICorner_22 = CreateInc("UICorner_22", "UICorner")
local TextBoxMultiLine = CreateInc("TextBoxMultiLine", "Frame")
local TextBox_2 = CreateInc("TextBox_2", "TextBox")
local UICorner_23 = CreateInc("UICorner_23", "UICorner")
local Image = CreateInc("Image", "Frame")
local ImageLabel = CreateInc("ImageLabel", "ImageLabel")
local UICorner_24 = CreateInc("UICorner_24", "UICorner")
local ExecBox = CreateInc("ExecBox", "Frame")
local TextBox_3 = CreateInc("TextBox_3", "TextBox")
local box = CreateInc("box", "TextButton")
local UITextSizeConstraint_7 = CreateInc("UITextSizeConstraint_7", "UITextSizeConstraint")
local UICorner_25 = CreateInc("UICorner_25", "UICorner")
local TextLabel_5 = CreateInc("TextLabel_5", "TextLabel")
local clippy = CreateInc("clippy", "TextButton")
local UITextSizeConstraint_8 = CreateInc("UITextSizeConstraint_8", "UITextSizeConstraint")
local UICorner_26 = CreateInc("UICorner_26", "UICorner")
local TextLabel_6 = CreateInc("TextLabel_6", "TextLabel")
local UICorner_27 = CreateInc("UICorner_27", "UICorner")
local Search = CreateInc("Search", "Frame")
local TextBox_4 = CreateInc("TextBox_4", "TextBox")
local UICorner_28 = CreateInc("UICorner_28", "UICorner")
local ActiveButton_3 = CreateInc("ActiveButton_3", "TextButton")
local UITextSizeConstraint_9 = CreateInc("UITextSizeConstraint_9", "UITextSizeConstraint")
local UICorner_29 = CreateInc("UICorner_29", "UICorner")
local TextLabel_7 = CreateInc("TextLabel_7", "TextLabel")
local ToggleBtn = CreateInc("ToggleBtn", "TextButton")
local ClickHandler = CreateInc("ClickHandler", "TextButton")
local Border_5 = CreateInc("Border_5", "Frame")
local Icon_3 = CreateInc("Icon_3", "ImageButton")
local UIAspectRatioConstraint_13 = CreateInc("UIAspectRatioConstraint_13", "UIAspectRatioConstraint")
local UIAspectRatioConstraint_14 = CreateInc("UIAspectRatioConstraint_14", "UIAspectRatioConstraint")
local UICorner_30 = CreateInc("UICorner_30", "UICorner")
local UICorner_31 = CreateInc("UICorner_31", "UICorner")


--Properties:

FluxusAndroidUI.Name = 'FluxusAndroidUI'
FluxusAndroidUI.Parent = rtContainer

Container.Name = 'Container'
Container.Parent = FluxusAndroidUI
Container.BackgroundColor3 = Global_Editor_Color
Container.BackgroundTransparency = 1.000
Container.Size = UDim2.new(1, 0, 1, 0)

Loader.Name = 'Loader'
Loader.Parent = Container
Loader.AnchorPoint = Vector2.new(0.5, 0.5)
Loader.BackgroundColor3 = Color3.fromRGB(36, 39, 58)
Loader.BorderColor3 = Color3.fromRGB(24, 25, 38)
Loader.BorderSizePixel = 0
Loader.Position = UDim2.new(0.5, 0, 0.5, 0)
Loader.Size = UDim2.new(0.5, 0, 0.5, 0)

UIAspectRatioConstraint.Parent = Loader

Border.Name = 'Border'
Border.Parent = Loader
Border.AnchorPoint = Vector2.new(0.5, 0.5)
Border.BackgroundColor3 = Color3.fromRGB(30, 32, 48)
Border.BorderSizePixel = 0
Border.Position = UDim2.new(0.5, 0, 0.5, 0)
Border.Size = UDim2.new(1, 8, 1, 8)
Border.ZIndex = -1

UICorner.CornerRadius = UDim.new(0, 20)
UICorner.Parent = Border

UICorner_2.CornerRadius = UDim.new(0, 16)
UICorner_2.Parent = Loader

Icon.Name = 'Icon'
Icon.Parent = Loader
Icon.AnchorPoint = Vector2.new(0.5, 0.5)
Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Icon.BackgroundTransparency = 1.000
Icon.Position = UDim2.new(0.5, 0, 0.5, 0)
Icon.Size = UDim2.new(0.75, 0, 0.75, 0)
Icon.Image = a['rbxassetid://11434416211']

UIAspectRatioConstraint_2.Parent = Icon

Key.Name = 'Key'
Key.Parent = Container
Key.AnchorPoint = Vector2.new(0.5, 0.5)
Key.BackgroundColor3 = Color3.fromRGB(36, 39, 58)
Key.BorderColor3 = Color3.fromRGB(24, 25, 38)
Key.BorderSizePixel = 0
Key.Position = UDim2.new(0.5, 0, 0.5, 0)
Key.Size = UDim2.new(0.97299999, 0, 0.660000026, 0)
Key.Visible = false

UIAspectRatioConstraint_3.Parent = Key
UIAspectRatioConstraint_3.AspectRatio = 2.250

Border_2.Name = 'Border'
Border_2.Parent = Key
Border_2.AnchorPoint = Vector2.new(0.5, 0.5)
Border_2.BackgroundColor3 = Color3.fromRGB(30, 32, 48)
Border_2.BorderSizePixel = 0
Border_2.Position = UDim2.new(0.5, 0, 0.5, 0)
Border_2.Size = UDim2.new(1, 8, 1, 8)
Border_2.ZIndex = -1

UICorner_3.CornerRadius = UDim.new(0, 20)
UICorner_3.Parent = Border_2

UICorner_4.CornerRadius = UDim.new(0, 16)
UICorner_4.Parent = Key

Icon_2.Name = 'Icon'
Icon_2.Parent = Key
Icon_2.AnchorPoint = Vector2.new(0.5, 0.5)
Icon_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Icon_2.BackgroundTransparency = 1.000
Icon_2.Position = UDim2.new(0.131224886, 0, 0.5, 0)
Icon_2.Size = UDim2.new(0.234455898, 0, 0.668276012, 0)
Icon_2.Image = a['rbxassetid://11434416211']

UIAspectRatioConstraint_4.Parent = Icon_2

Container_2.Name = 'Container'
Container_2.Parent = Key
Container_2.AnchorPoint = Vector2.new(0, 0.5)
Container_2.BackgroundColor3 = Global_Editor_Color
Container_2.Position = UDim2.new(0.25999999, 0, 0.5, 0)
Container_2.Size = UDim2.new(0.714599609, 0, 0.877767384, 0)

UICorner_5.CornerRadius = UDim.new(0, 20)
UICorner_5.Parent = Container_2

CheckKey.Name = 'CheckKey'
CheckKey.Parent = Container_2
CheckKey.AnchorPoint = Vector2.new(1, 1)
CheckKey.BackgroundColor3 = Global_Button_Color
CheckKey.Position = UDim2.new(1, -8, 1.00000012, -8)
CheckKey.Size = UDim2.new(0.421657592, 0, 0.245564342, 0)
CheckKey.AutoButtonColor = false
CheckKey.Font = Enum.Font.SourceSans
CheckKey.Text = ''
CheckKey.TextColor3 = Global_Text_Color
CheckKey.TextSize = 14.000

UICorner_6.CornerRadius = UDim.new(0, 16)
UICorner_6.Parent = CheckKey

TextLabel.Parent = CheckKey
TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
TextLabel.Size = UDim2.new(1, 0, 0.699999988, 0)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = _G.fluxus_ui_values["key_check_key"]
TextLabel.TextColor3 = Global_Text_Color
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true

GetKey.Name = 'GetKey'
GetKey.Parent = Container_2
GetKey.AnchorPoint = Vector2.new(0, 1)
GetKey.BackgroundColor3 = Color3.fromRGB(30, 32, 48)
GetKey.Position = UDim2.new(0, 8, 1, -8)
GetKey.Size = UDim2.new(0.421657592, 0, 0.245564342, 0)
GetKey.AutoButtonColor = false
GetKey.Font = Enum.Font.SourceSans
GetKey.Text = ' '
GetKey.TextColor3 = Global_Text_Color
GetKey.TextSize = 14.000

UICorner_7.CornerRadius = UDim.new(0, 16)
UICorner_7.Parent = GetKey

TextLabel_2.Parent = GetKey
TextLabel_2.AnchorPoint = Vector2.new(0.5, 0.5)
TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.BackgroundTransparency = 1.000
TextLabel_2.Position = UDim2.new(0.5, 0, 0.5, 0)
TextLabel_2.Size = UDim2.new(1, 0, 0.699999988, 0)
TextLabel_2.Font = Enum.Font.SourceSans
TextLabel_2.Text = _G.fluxus_ui_values["key_get_key"]
TextLabel_2.TextColor3 = Global_Text_Color
TextLabel_2.TextScaled = true
TextLabel_2.TextSize = 14.000
TextLabel_2.TextWrapped = true

KeyContainer.Name = 'KeyContainer'
KeyContainer.Parent = Container_2
KeyContainer.AnchorPoint = Vector2.new(0.5, 0)
KeyContainer.BackgroundColor3 = Color3.fromRGB(36, 39, 58)
KeyContainer.Position = UDim2.new(0.5, 0, 0, 8)
KeyContainer.Size = UDim2.new(1, -16, 0.754000008, -24)
KeyContainer.Font = Enum.Font.SourceSans
KeyContainer.Text = ''
KeyContainer.TextColor3 = Global_Text_Color
KeyContainer.TextSize = 16.000
KeyContainer.TextWrapped = true
KeyContainer.TextYAlignment = Enum.TextYAlignment.Top

UICorner_8.CornerRadius = UDim.new(0, 16)
UICorner_8.Parent = KeyContainer

Instructions.Name = 'Instructions'
Instructions.Parent = KeyContainer
Instructions.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Instructions.BackgroundTransparency = 1.000
Instructions.Position = UDim2.new(0.0214072056, 0, 0.0587453023, 0)
Instructions.Size = UDim2.new(0.952989757, 0, 0.555652499, 0)
Instructions.Font = Enum.Font.SourceSans
Instructions.Text =_G.fluxus_ui_values["key_instructions"]
Instructions.TextColor3 = Global_Text_Color
Instructions.TextScaled = true
Instructions.TextSize = 14.000
Instructions.TextWrapped = true

KeyBox.Name = 'KeyBox'
KeyBox.Parent = KeyContainer
KeyBox.AnchorPoint = Vector2.new(0.5, 1)
KeyBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.BackgroundTransparency = 1.000
KeyBox.Position = UDim2.new(0.50000006, 0, 0.94668895, 0)
KeyBox.Size = UDim2.new(1.00000024, 0, 0.257028431, 0)
KeyBox.Font = Enum.Font.SourceSans
KeyBox.PlaceholderText = _G.fluxus_ui_values["key_paste_key_here"]
KeyBox.Text = ''
KeyBox.TextColor3 = Global_Text_Color
KeyBox.TextScaled = true
KeyBox.TextSize = 14.000
KeyBox.TextWrapped = true

minimizeContainer.Name = 'minimizeContainer'
minimizeContainer.Parent = Key
minimizeContainer.AnchorPoint = Vector2.new(0.5, 0)
minimizeContainer.BackgroundColor3 = Color3.fromRGB(30, 32, 48)
minimizeContainer.BorderSizePixel = 0
minimizeContainer.Position = UDim2.new(1, 0, 0, 10)
minimizeContainer.Size = UDim2.new(0.175999999, 0, 0.207000002, 0)
minimizeContainer.ZIndex = -1

UICorner_9.CornerRadius = UDim.new(0, 20)
UICorner_9.Parent = minimizeContainer

_1Minimize.Name = '1Minimize'
_1Minimize.Parent = minimizeContainer
_1Minimize.AnchorPoint = Vector2.new(1, 0.5)
_1Minimize.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
_1Minimize.BackgroundTransparency = 1.000
_1Minimize.BorderSizePixel = 0
_1Minimize.Position = UDim2.new(1, 0, 0.5, 0)
_1Minimize.Size = UDim2.new(0.5, 0, 1, 0)
_1Minimize.ZIndex = 0
_1Minimize.Image = a['rbxassetid://11447435879']

UIAspectRatioConstraint_5.Parent = _1Minimize

UIAspectRatioConstraint_6.Parent = minimizeContainer
UIAspectRatioConstraint_6.AspectRatio = 2.000

TransitionUI.Name = 'TransitionUI'
TransitionUI.Parent = Container
TransitionUI.AnchorPoint = Vector2.new(0.5, 0.5)
TransitionUI.BackgroundColor3 = Color3.fromRGB(36, 39, 58)
TransitionUI.BorderColor3 = Color3.fromRGB(24, 25, 38)
TransitionUI.BorderSizePixel = 0
TransitionUI.Position = UDim2.new(0.5, 0, 0.5, 0)
TransitionUI.Size = UDim2.new(0.5, 0, 0.5, 0)
TransitionUI.Visible = false
TransitionUI.ZIndex = 50

Border_3.Name = 'Border'
Border_3.Parent = TransitionUI
Border_3.AnchorPoint = Vector2.new(0.5, 0.5)
Border_3.BackgroundColor3 = Color3.fromRGB(30, 32, 48)
Border_3.BorderSizePixel = 0
Border_3.Position = UDim2.new(0.5, 0, 0.5, 0)
Border_3.Size = UDim2.new(1, 8, 1, 8)
Border_3.ZIndex = -1

UICorner_10.CornerRadius = UDim.new(0, 20)
UICorner_10.Parent = Border_3

UICorner_11.CornerRadius = UDim.new(0, 16)
UICorner_11.Parent = TransitionUI

MainUI.Name = 'MainUI'
MainUI.Parent = Container
MainUI.AnchorPoint = Vector2.new(0.5, 0.5)
MainUI.BackgroundColor3 = Color3.fromRGB(36, 39, 58)
MainUI.BorderColor3 = Color3.fromRGB(24, 25, 38)
MainUI.BorderSizePixel = 0
MainUI.Position = UDim2.new(0.5, 0, 0.5, 0)
MainUI.Size = UDim2.new(0.808145046, 0, 0.79543215, 0)
if(Global_Image ~= nil) then
  if(type(Global_Image) == "userdata") then
    MainUI.BackgroundColor3 = Global_Image
  else
    MainUI.Image = Global_Image
  end
end

Border_4.Name = 'Border'
Border_4.Parent = MainUI
Border_4.AnchorPoint = Vector2.new(0.5, 0.5)
Border_4.BackgroundColor3 = Color3.fromRGB(30, 32, 48)
Border_4.BorderSizePixel = 0
Border_4.Position = UDim2.new(0.5, 0, 0.5, 0)
Border_4.Size = UDim2.new(1, 8, 1, 8)
Border_4.ZIndex = -1

UICorner_12.CornerRadius = UDim.new(0, 20)
UICorner_12.Parent = Border_4

UICorner_13.CornerRadius = UDim.new(0, 16)
UICorner_13.Parent = MainUI

Tabs.Name = 'Tabs'
Tabs.Parent = MainUI
Tabs.BackgroundColor3 = Global_Tabs_Color
Tabs.BorderSizePixel = 0
Tabs.ClipsDescendants = true
Tabs.Size = UDim2.new(0, 64, 1, 0)

Scroller.Name = 'Scroller'
Scroller.Parent = Tabs
Scroller.Active = true
Scroller.AnchorPoint = Vector2.new(0.5, 0.5)
Scroller.BackgroundColor3 = Color3.fromRGB(30, 32, 48)
Scroller.BackgroundTransparency = 0.999
Scroller.BorderColor3 = Color3.fromRGB(30, 32, 48)
Scroller.Position = UDim2.new(0.5, 0, 0.563784838, 0)
Scroller.Size = UDim2.new(1, 0, 0.905351698, -32)
Scroller.BottomImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png'
Scroller.ScrollBarThickness = 2
Scroller.TopImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png'
Scroller.VerticalScrollBarInset = Enum.ScrollBarInset.Always

UIListLayout.Parent = Scroller
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)

Btn.Name = 'Btn'
Btn.Parent = Scroller
Btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Btn.BackgroundTransparency = 1.000
Btn.Size = UDim2.new(1, 0, 1, 0)
Btn.Image = a['rbxassetid://11434416211']

UIAspectRatioConstraint_7.Parent = Btn

UICorner_14.CornerRadius = UDim.new(0, 16)
UICorner_14.Parent = Btn

UICorner_15.CornerRadius = UDim.new(0, 16)
UICorner_15.Parent = Tabs

_1Minimize_2.Name = '1Minimize'
_1Minimize_2.Parent = Tabs
_1Minimize_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
_1Minimize_2.BackgroundTransparency = 1.000
_1Minimize_2.BorderSizePixel = 0
_1Minimize_2.Size = UDim2.new(1, 0, 1, 0)
_1Minimize_2.Image = a['rbxassetid://11447435879']

UIAspectRatioConstraint_8.Parent = _1Minimize_2

UIListLayout_2.Parent = Tabs
UIListLayout_2.Padding = UDim.new(0, 6)

Content.Name = 'Content'
Content.Parent = MainUI
Content.Active = true
Content.AnchorPoint = Vector2.new(1, 0.5)
Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Content.BackgroundTransparency = 0.999
Content.BorderSizePixel = 0
Content.Position = UDim2.new(0.995839119, -8, 0.5, 0)
Content.Size = UDim2.new(0.995839119, -80, 1, -16)
Content.BottomImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png'
Content.ScrollBarThickness = 2
Content.TopImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png'
Content.VerticalScrollBarInset = Enum.ScrollBarInset.Always

UIListLayout_3.Parent = Content
UIListLayout_3.Padding = UDim.new(0, 8)

Spacer.Name = 'Spacer'
Spacer.Parent = Content
Spacer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Spacer.BackgroundTransparency = 0.999
Spacer.Position = UDim2.new(0, 0, 0.204823568, 0)
Spacer.Size = UDim2.new(0.995999992, 0, 0, 5)

Text.Name = 'Text'
Text.Parent = Content
Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Text.BackgroundTransparency = 1.000
Text.Size = UDim2.new(0.995999992, 0, 0, 30)

Label.Name = 'Label'
Label.Parent = Text
Label.AnchorPoint = Vector2.new(0, 0.5)
Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Label.BackgroundTransparency = 1.000
Label.Position = UDim2.new(0.00656450912, 0, 0.5, 0)
Label.Size = UDim2.new(0.96189183, 0, 1, -4)
Label.Font = Enum.Font.SourceSans
Label.TextColor3 = Global_Text_Color
Label.TextSize = 20.000
Label.TextWrapped = true
Label.TextXAlignment = Enum.TextXAlignment.Left

Button.Name = 'Button'
Button.Parent = Content
Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Button.BackgroundTransparency = 1.000
Button.Position = UDim2.new(-3.69178785e-08, 0, 0, 0)
Button.Size = UDim2.new(0.994000018, 0, 0, 30)

WithText.Name = 'WithText'
WithText.Parent = Button
WithText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
WithText.BackgroundTransparency = 1.000
WithText.Size = UDim2.new(1, 0, 1, 0)
WithText.Visible = false

ActiveButton.Name = 'ActiveButton'
ActiveButton.Parent = WithText
ActiveButton.AnchorPoint = Vector2.new(1, 0.5)
ActiveButton.BackgroundColor3 = Global_Button_Color
ActiveButton.Position = UDim2.new(0.999999881, -8, 0.5, 0)
ActiveButton.Size = UDim2.new(1, -16, 1, -4)
ActiveButton.Visible = false
ActiveButton.AutoButtonColor = false
ActiveButton.Font = Enum.Font.SourceSans
ActiveButton.TextColor3 = Global_Text_Color
ActiveButton.TextScaled = true
ActiveButton.TextSize = 14.000
ActiveButton.TextWrapped = true

UIAspectRatioConstraint_9.Parent = ActiveButton
UIAspectRatioConstraint_9.AspectRatio = 3.000
UIAspectRatioConstraint_9.DominantAxis = Enum.DominantAxis.Height

UITextSizeConstraint.Parent = ActiveButton
UITextSizeConstraint.MaxTextSize = 50

UICorner_16.CornerRadius = UDim.new(0, 16)
UICorner_16.Parent = ActiveButton

Label_2.Name = 'Label'
Label_2.Parent = WithText
Label_2.AnchorPoint = Vector2.new(0, 0.5)
Label_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Label_2.BackgroundTransparency = 1.000
Label_2.Position = UDim2.new(0, 0, 0.5, 0)
Label_2.Size = UDim2.new(0.892810702, 0, 1, -4)
Label_2.Font = Enum.Font.SourceSans
Label_2.TextColor3 = Global_Text_Color
Label_2.TextScaled = true
Label_2.TextSize = 14.000
Label_2.TextWrapped = true
Label_2.TextXAlignment = Enum.TextXAlignment.Left

PassiveButton.Name = 'PassiveButton'
PassiveButton.Parent = WithText
PassiveButton.AnchorPoint = Vector2.new(1, 0.5)
PassiveButton.BackgroundColor3 = Color3.fromRGB(30, 32, 48)
PassiveButton.Position = UDim2.new(0.999999881, -8, 0.5, 0)
PassiveButton.Size = UDim2.new(1, -16, 1, -4)
PassiveButton.AutoButtonColor = false
PassiveButton.Font = Enum.Font.SourceSans
PassiveButton.TextColor3 = Global_Text_Color
PassiveButton.TextScaled = true
PassiveButton.TextSize = 14.000
PassiveButton.TextWrapped = true

UIAspectRatioConstraint_10.Parent = PassiveButton
UIAspectRatioConstraint_10.AspectRatio = 3.000
UIAspectRatioConstraint_10.DominantAxis = Enum.DominantAxis.Height

UITextSizeConstraint_2.Parent = PassiveButton
UITextSizeConstraint_2.MaxTextSize = 50

UICorner_17.CornerRadius = UDim.new(0, 16)
UICorner_17.Parent = PassiveButton

NoText.Name = 'NoText'
NoText.Parent = Button
NoText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
NoText.BackgroundTransparency = 1.000
NoText.Size = UDim2.new(1, 0, 1, 0)

ActiveButton_2.Name = 'ActiveButton'
ActiveButton_2.Parent = NoText
ActiveButton_2.AnchorPoint = Vector2.new(1, 0.5)
ActiveButton_2.BackgroundColor3 = Global_Button_Color
ActiveButton_2.Position = UDim2.new(1.00895214, -8, 0.5, 0)
ActiveButton_2.Size = UDim2.new(1.01790428, -16, 1, -4)
ActiveButton_2.AutoButtonColor = false
ActiveButton_2.Font = Enum.Font.SourceSans
ActiveButton_2.Text = ' '
ActiveButton_2.TextColor3 = Global_Text_Color
ActiveButton_2.TextScaled = true
ActiveButton_2.TextSize = 14.000
ActiveButton_2.TextWrapped = true

UITextSizeConstraint_3.Parent = ActiveButton_2
UITextSizeConstraint_3.MaxTextSize = 50

UICorner_18.CornerRadius = UDim.new(0, 16)
UICorner_18.Parent = ActiveButton_2

TextLabel_3.Parent = ActiveButton_2
TextLabel_3.AnchorPoint = Vector2.new(0.5, 0.5)
TextLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_3.BackgroundTransparency = 1.000
TextLabel_3.Position = UDim2.new(0.5, 0, 0.5, 0)
TextLabel_3.Size = UDim2.new(1, -16, 1, -6)
TextLabel_3.Font = Enum.Font.SourceSans
TextLabel_3.TextColor3 = Global_Text_Color
TextLabel_3.TextScaled = true
TextLabel_3.TextSize = 14.000
TextLabel_3.TextWrapped = true

PassiveButton_2.Name = 'PassiveButton'
PassiveButton_2.Parent = NoText
PassiveButton_2.AnchorPoint = Vector2.new(1, 0.5)
PassiveButton_2.BackgroundColor3 = Color3.fromRGB(30, 32, 48)
PassiveButton_2.Position = UDim2.new(0.999999881, -8, 0.5, 0)
PassiveButton_2.Size = UDim2.new(1, -16, 1, -4)
PassiveButton_2.Visible = false
PassiveButton_2.AutoButtonColor = false
PassiveButton_2.Font = Enum.Font.SourceSans
PassiveButton_2.Text = ' '
PassiveButton_2.TextColor3 = Global_Text_Color
PassiveButton_2.TextScaled = true
PassiveButton_2.TextSize = 14.000
PassiveButton_2.TextWrapped = true

UITextSizeConstraint_4.Parent = PassiveButton_2
UITextSizeConstraint_4.MaxTextSize = 50

UICorner_19.CornerRadius = UDim.new(0, 16)
UICorner_19.Parent = PassiveButton_2

TextLabel_4.Parent = PassiveButton_2
TextLabel_4.AnchorPoint = Vector2.new(0.5, 0.5)
TextLabel_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_4.BackgroundTransparency = 1.000
TextLabel_4.Position = UDim2.new(0.5, 0, 0.5, 0)
TextLabel_4.Size = UDim2.new(1, -16, 1, -6)
TextLabel_4.Font = Enum.Font.SourceSans
TextLabel_4.TextColor3 = Global_Text_Color
TextLabel_4.TextScaled = true
TextLabel_4.TextSize = 14.000
TextLabel_4.TextWrapped = true

Checkbox.Name = 'Checkbox'
Checkbox.Parent = Content
Checkbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Checkbox.BackgroundTransparency = 1.000
Checkbox.Size = UDim2.new(0.995999992, 0, 0, 30)

Checked.Name = 'Checked'
Checked.Parent = Checkbox
Checked.AnchorPoint = Vector2.new(1, 0.5)
Checked.BackgroundColor3 = Global_Button_Color
Checked.Position = UDim2.new(0.999999881, -8, 0.5, 0)
Checked.Size = UDim2.new(1, -16, 1, -4)
Checked.AutoButtonColor = false
Checked.Font = Enum.Font.SourceSans
Checked.Text = ' '
Checked.TextColor3 = Global_Text_Color
Checked.TextScaled = true
Checked.TextSize = 14.000
Checked.TextWrapped = true

UIAspectRatioConstraint_11.Parent = Checked
UIAspectRatioConstraint_11.DominantAxis = Enum.DominantAxis.Height

UITextSizeConstraint_5.Parent = Checked
UITextSizeConstraint_5.MaxTextSize = 50

UICorner_20.CornerRadius = UDim.new(0, 16)
UICorner_20.Parent = Checked

Unchecked.Name = 'Unchecked'
Unchecked.Parent = Checkbox
Unchecked.AnchorPoint = Vector2.new(1, 0.5)
Unchecked.BackgroundColor3 = Color3.fromRGB(30, 32, 48)
Unchecked.Position = UDim2.new(0.999999881, -8, 0.5, 0)
Unchecked.Size = UDim2.new(1, -16, 1, -4)
Unchecked.Visible = false
Unchecked.AutoButtonColor = false
Unchecked.Font = Enum.Font.SourceSans
Unchecked.Text = ' '
Unchecked.TextColor3 = Global_Text_Color
Unchecked.TextScaled = true
Unchecked.TextSize = 14.000
Unchecked.TextWrapped = true

UIAspectRatioConstraint_12.Parent = Unchecked
UIAspectRatioConstraint_12.DominantAxis = Enum.DominantAxis.Height

UITextSizeConstraint_6.Parent = Unchecked
UITextSizeConstraint_6.MaxTextSize = 50

UICorner_21.CornerRadius = UDim.new(0, 16)
UICorner_21.Parent = Unchecked

Label_3.Name = 'Label'
Label_3.Parent = Checkbox
Label_3.AnchorPoint = Vector2.new(0, 0.5)
Label_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Label_3.BackgroundTransparency = 1.000
Label_3.Position = UDim2.new(0.0121801738, 0, 0.5, 0)
Label_3.Size = UDim2.new(0.587819874, 0, 1, -4)
Label_3.Font = Enum.Font.SourceSans
Label_3.TextColor3 = Global_Text_Color
Label_3.TextScaled = true
Label_3.TextSize = 14.000
Label_3.TextWrapped = true
Label_3.TextXAlignment = Enum.TextXAlignment.Left

Textbox.Name = 'Textbox'
Textbox.Parent = Content
Textbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Textbox.BackgroundTransparency = 1.000
Textbox.Size = UDim2.new(0.995999992, 0, 0, 30)

TextBox.Parent = Textbox
TextBox.AnchorPoint = Vector2.new(1, 0.5)
TextBox.BackgroundColor3 = Global_Editor_Color
TextBox.Position = UDim2.new(0.997991979, 0, 0.5, 0)
TextBox.Size = UDim2.new(1.01599658, -16, 1.06666672, 0)
TextBox.Font = Enum.Font.SourceSans
TextBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
TextBox.PlaceholderText = 'PlaceholderPlaceholder'
TextBox.Text = ''
TextBox.TextColor3 = Global_Text_Color
TextBox.TextSize = 14.000

UICorner_22.CornerRadius = UDim.new(0, 16)
UICorner_22.Parent = TextBox

TextBoxMultiLine.Name = 'TextBoxMultiLine'
TextBoxMultiLine.Parent = Content
TextBoxMultiLine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextBoxMultiLine.BackgroundTransparency = 1.000
TextBoxMultiLine.Position = UDim2.new(0, 0, 0.0424371213, 0)
TextBoxMultiLine.Size = UDim2.new(0.990999997, 0, 0, 193)

TextBox_2.Parent = TextBoxMultiLine
TextBox_2.AnchorPoint = Vector2.new(1, 0.5)
TextBox_2.BackgroundColor3 = Global_Editor_Color
TextBox_2.Position = UDim2.new(1.0030272, 0, 0.499999851, 0)
TextBox_2.Size = UDim2.new(1.02098584, -16, 1, 0)
TextBox_2.ClearTextOnFocus = false
TextBox_2.Font = Enum.Font.SourceSans
TextBox_2.MultiLine = true
TextBox_2.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
TextBox_2.PlaceholderText = 'PlaceholderPlaceholder'
TextBox_2.Text = ''
TextBox_2.TextColor3 = Global_Text_Color
TextBox_2.TextSize = 14.000

UICorner_23.CornerRadius = UDim.new(0, 16)
UICorner_23.Parent = TextBox_2

Image.Name = 'Image'
Image.Parent = Content
Image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Image.BackgroundTransparency = 1.000
Image.Position = UDim2.new(-3.69178785e-08, 0, 0.218284875, 0)
Image.Size = UDim2.new(0.994000018, 0, 0, 128)

ImageLabel.Parent = Image
ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel.BackgroundTransparency = 1.000
ImageLabel.Size = UDim2.new(1, 0, 1, 0)
ImageLabel.Image = 'rbxassetid://11440609775'
ImageLabel.ScaleType = Enum.ScaleType.Crop

UICorner_24.Parent = ImageLabel

ExecBox.Name = 'ExecBox'
ExecBox.Parent = Content
ExecBox.BackgroundColor3 = Global_Editor_Color
ExecBox.Position = UDim2.new(-0.0133180944, 0, 0.0632952526, 0)
ExecBox.Size = UDim2.new(0.997780323, 0, -0.0725846514, 512)
if(Global_Image ~= nil) then
  if(type(Global_Image) == "userdata") then
    ExecBox.BackgroundTransparency = 0.3
  else
    ExecBox.BackgroundTransparency = 0.1
  end
end

if(Global_Editor_Transparent) then
    ExecBox.BackgroundTransparency = 1
end

TextBox_3.Parent = ExecBox
TextBox_3.AnchorPoint = Vector2.new(0.5, 0)
TextBox_3.BackgroundColor3 = Global_Editor_Color
TextBox_3.BackgroundTransparency = 0.999
TextBox_3.BorderSizePixel = 0
TextBox_3.Position = UDim2.new(0.501114726, 0, 0.0430178083, 0)
TextBox_3.Size = UDim2.new(0.962097406, 0, 0.961592555, -48)
TextBox_3.ClearTextOnFocus = false
TextBox_3.Font = Enum.Font.RobotoMono
TextBox_3.MultiLine = true
TextBox_3.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
TextBox_3.PlaceholderText = 'print(\'Hello World!\')'
TextBox_3.Text = ''
TextBox_3.TextColor3 = Global_Text_Color
TextBox_3.TextSize = 14.000
TextBox_3.TextXAlignment = Enum.TextXAlignment.Left
TextBox_3.TextYAlignment = Enum.TextYAlignment.Top

box.Name = 'box'
box.Parent = ExecBox
box.AnchorPoint = Vector2.new(0, 1)
box.BackgroundColor3 = Global_Button_Color
box.Position = UDim2.new(0, 4, 1, -4)
box.Size = UDim2.new(0.5, -8, 0, 35)
box.AutoButtonColor = false
box.Font = Enum.Font.SourceSans
box.Text = ' '
box.TextColor3 = Global_Text_Color
box.TextScaled = true
box.TextSize = 14.000
box.TextWrapped = true

UITextSizeConstraint_7.Parent = box
UITextSizeConstraint_7.MaxTextSize = 50

UICorner_25.CornerRadius = UDim.new(0, 16)
UICorner_25.Parent = box

TextLabel_5.Parent = box
TextLabel_5.AnchorPoint = Vector2.new(0.5, 0.5)
TextLabel_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_5.BackgroundTransparency = 1.000
TextLabel_5.Position = UDim2.new(0.5, 0, 0.5, 0)
TextLabel_5.Size = UDim2.new(1, -16, 1, -6)
TextLabel_5.Font = Enum.Font.SourceSans
TextLabel_5.Text = _G.fluxus_ui_values["execute_from_textbox"]
TextLabel_5.TextColor3 = Global_Text_Color
TextLabel_5.TextScaled = true
TextLabel_5.TextSize = 14.000
TextLabel_5.TextWrapped = true

clippy.Name = 'clippy'
clippy.Parent = ExecBox
clippy.AnchorPoint = Vector2.new(1, 1)
clippy.BackgroundColor3 = Global_Button_Color
clippy.Position = UDim2.new(1, -4, 1, -4)
clippy.Size = UDim2.new(0.5, -8, 0, 35)
clippy.AutoButtonColor = false
clippy.Font = Enum.Font.SourceSans
clippy.Text = ' '
clippy.TextColor3 = Global_Text_Color
clippy.TextScaled = true
clippy.TextSize = 14.000
clippy.TextWrapped = true

UITextSizeConstraint_8.Parent = clippy
UITextSizeConstraint_8.MaxTextSize = 50

UICorner_26.CornerRadius = UDim.new(0, 16)
UICorner_26.Parent = clippy

TextLabel_6.Parent = clippy
TextLabel_6.AnchorPoint = Vector2.new(0.5, 0.5)
TextLabel_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_6.BackgroundTransparency = 1.000
TextLabel_6.Position = UDim2.new(0.5, 0, 0.5, 0)
TextLabel_6.Size = UDim2.new(1, -16, 1, -6)
TextLabel_6.Font = Enum.Font.SourceSans
TextLabel_6.Text = _G.fluxus_ui_values["execute_from_clipboard"]
TextLabel_6.TextColor3 = Global_Text_Color
TextLabel_6.TextScaled = true
TextLabel_6.TextSize = 14.000
TextLabel_6.TextWrapped = true

UICorner_27.CornerRadius = UDim.new(0, 16)
UICorner_27.Parent = ExecBox

Search.Name = 'Search'
Search.Parent = Content
Search.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Search.BackgroundTransparency = 1.000
Search.Position = UDim2.new(3.3869668e-08, 0, 0.364753366, 0)
Search.Size = UDim2.new(0.991793573, 0, 0, 30)

TextBox_4.Parent = Search
TextBox_4.AnchorPoint = Vector2.new(1, 0.5)
TextBox_4.BackgroundColor3 = Global_Editor_Color
TextBox_4.Position = UDim2.new(0.768081725, 0, 0.5, 0)
TextBox_4.Size = UDim2.new(0.786086261, -16, 1.06666672, 0)
TextBox_4.Font = Enum.Font.SourceSans
TextBox_4.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
TextBox_4.PlaceholderText = _G.fluxus_ui_values["search_query_text"]
TextBox_4.Text = ''
TextBox_4.TextColor3 = Global_Text_Color
TextBox_4.TextSize = 14.000

UICorner_28.CornerRadius = UDim.new(0, 16)
UICorner_28.Parent = TextBox_4

ActiveButton_3.Name = 'ActiveButton'
ActiveButton_3.Parent = Search
ActiveButton_3.AnchorPoint = Vector2.new(1, 0.5)
ActiveButton_3.BackgroundColor3 = Global_Button_Color
ActiveButton_3.Position = UDim2.new(1.00895214, -8, 0.5, 0)
ActiveButton_3.Size = UDim2.new(0.242938325, -16, 1.20000005, -4)
ActiveButton_3.AutoButtonColor = false
ActiveButton_3.Font = Enum.Font.SourceSans
ActiveButton_3.Text = ' '
ActiveButton_3.TextColor3 = Global_Text_Color
ActiveButton_3.TextScaled = true
ActiveButton_3.TextSize = 14.000
ActiveButton_3.TextWrapped = true

UITextSizeConstraint_9.Parent = ActiveButton_3
UITextSizeConstraint_9.MaxTextSize = 50

UICorner_29.CornerRadius = UDim.new(0, 16)
UICorner_29.Parent = ActiveButton_3

TextLabel_7.Parent = ActiveButton_3
TextLabel_7.AnchorPoint = Vector2.new(0.5, 0.5)
TextLabel_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_7.BackgroundTransparency = 1.000
TextLabel_7.Position = UDim2.new(0.5, 0, 0.5, 0)
TextLabel_7.Size = UDim2.new(1, -16, 1, -6)
TextLabel_7.Font = Enum.Font.SourceSans
TextLabel_7.Text = _G.fluxus_ui_values["submit_query"]
TextLabel_7.TextColor3 = Global_Text_Color
TextLabel_7.TextScaled = true
TextLabel_7.TextSize = 14.000
TextLabel_7.TextWrapped = true

ToggleBtn.Name = 'ToggleBtn'
ToggleBtn.Parent = Container
ToggleBtn.BackgroundColor3 = Color3.fromRGB(36, 39, 58)
ToggleBtn.BorderColor3 = Color3.fromRGB(24, 25, 38)
ToggleBtn.BorderSizePixel = 0
ToggleBtn.Position = UDim2.new(0, 16, 0, 16)
ToggleBtn.Size = UDim2.new(0.0719999969, 0, 0, 32)
ToggleBtn.Visible = false

UIAspectRatioConstraint_13.Parent = ToggleBtn

Border_5.Name = 'Border'
Border_5.Parent = ToggleBtn
Border_5.AnchorPoint = Vector2.new(0.5, 0.5)
Border_5.BackgroundColor3 = Color3.fromRGB(30, 32, 48)
Border_5.BorderSizePixel = 0
Border_5.Position = UDim2.new(0.5, 0, 0.5, 0)
Border_5.Size = UDim2.new(1, 8, 1, 8)
Border_5.ZIndex = -1

UICorner_30.CornerRadius = UDim.new(0, 20)
UICorner_30.Parent = Border_5

UICorner_31.CornerRadius = UDim.new(0, 16)
UICorner_31.Parent = ToggleBtn

Icon_3.Name = 'Icon'
Icon_3.Parent = ToggleBtn
Icon_3.AnchorPoint = Vector2.new(0.5, 0.5)
Icon_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Icon_3.BackgroundTransparency = 1.000
Icon_3.Position = UDim2.new(0.5, 0, 0.5, 0)
Icon_3.Size = UDim2.new(0.75, 0, 0.75, 0)
Icon_3.Image = 'rbxassetid://13327193518'

UIAspectRatioConstraint_14.Parent = Icon_3

ClickHandler.Name = 'ClickHandler'
ClickHandler.Parent = ToggleBtn
ClickHandler.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ClickHandler.BackgroundTransparency = 0.990
ClickHandler.Size = UDim2.new(1, 0, 1, 0)
ClickHandler.ZIndex = 2
ClickHandler.Font = Enum.Font.SourceSans
ClickHandler.Text = ' '
ClickHandler.TextColor3 = Color3.fromRGB(0, 0, 0)
ClickHandler.TextSize = 14.000

local object1 = rtContainer:GetChildren()[1];
(object1 or {}).Parent = nil
rtContainer:Destroy()
return object1

end;
modules['lib/ui/CreateUI.lua'].cache = null;
modules['lib/ui/CreateUI.lua'].isCached = false;

----

modules['lib/ui/index.lua'] = {};
modules['lib/ui/index.lua'].load = function()
-- Deps
local BaseUI, Dragger = require 'lib/ui/CreateUI.lua', require 'lib/ui/RBXDragger'
local CFGLib = require 'lib/cfg'
local cfg = CFGLib.new 'li.flux.ui.builtins'
local betas = CFGLib.new 'li.flux.ui.betaflags'

-- Services
local TweenService = game:GetService 'TweenService'

-- Code
local API = {} -- Public API, UI lib shit
local InternalAPI = {} -- Internal API, only accessible in this project, not for pulic use | ONLY ACCESS THINGS LIKE PREMIUM WITHIN THIS!
InternalAPI.Components = {}

--- Creates the UI Instance & Registers it with the Internal API Object
InternalAPI.CreateUI = function()
  InternalAPI.UI = BaseUI
  for _, o in pairs(InternalAPI.UI:GetDescendants()) do
    if o:IsA 'TextLabel' or o:IsA 'TextButton' then
      o.RichText = true
    elseif o:IsA 'UIListLayout' then
      o.SortOrder = Enum.SortOrder.Name
    end
  end
  InternalAPI.UI.Container.Position = UDim2.fromScale(0.5, 0.5)
  InternalAPI.UI.Container.AnchorPoint = Vector2.new(0.5, 0.5)
  local UIFrames = {}
  for _, o in pairs(InternalAPI.UI.Container:GetChildren()) do
    o.Visible = o.Name == 'Loader'
    UIFrames[o.Name] = o
  end
  InternalAPI.UIFrames = UIFrames
  for _, o in pairs(UIFrames.MainUI.Content:GetChildren()) do
    if o:IsA 'Frame' then
      InternalAPI.Components[o.Name] = o:Clone()
      InternalAPI.Components[o.Name].Size =
        UDim2.new(InternalAPI.Components[o.Name].Size.X, UDim.new(0, InternalAPI.Components[o.Name].AbsoluteSize.Y))
      o:Destroy()
    end
  end
  InternalAPI.BaseContent = UIFrames.MainUI.Content:Clone()
  UIFrames.MainUI.Content:Destroy()
  InternalAPI.SidebarScroller = UIFrames.MainUI.Tabs.Scroller
  InternalAPI.SidebarBtn = InternalAPI.SidebarScroller.Btn:Clone()
  InternalAPI.SidebarScroller.Btn:Destroy()
  game:GetService('RunService').RenderStepped:Connect(function()
    InternalAPI.SidebarScroller.CanvasSize =
      UDim2.fromOffset(0, InternalAPI.SidebarScroller.UIListLayout.AbsoluteContentSize.Y)
  end)
  -- infinite loading anim
  local ti = TweenInfo.new(cfg:get 'fastanim' and 0.3 or 1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true, 0.2)
  local tionce =
    TweenInfo.new(cfg:get 'fastanim' and 0.3 or 1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false, 0)
  TweenService:Create(UIFrames.Loader.Icon, ti, {
    ImageTransparency = 1,
  }):Play()
  -- prepare for initial opening icon
  local endSize = UIFrames.Loader.Size
  UIFrames.Loader.Size = UDim2.new(0, 0, 0, 0)
  -- parent it
  InternalAPI.UI.Parent = gethui();
  API:SetSmallUIEnabled(isfile and isfile '.desktop-mode')
  -- tween it
  local t = TweenService:Create(UIFrames.Loader, tionce, {
    Size = endSize,
  })
  t:Play()
  t.Completed:Wait()
  InternalAPI.UIFrames.TransitionUI.Size = UDim2.fromOffset(UIFrames.Loader.AbsoluteSize.X, UIFrames.Loader.AbsoluteSize.Y)
  InternalAPI.UIFrames.ToggleBtn.ClickHandler.MouseButton1Click:Connect(function()
    API:Unminimize()
  end)
  Dragger(InternalAPI.UIFrames.ToggleBtn, InternalAPI.UIFrames.ToggleBtn.ClickHandler)
  -- Prepare final UI in new thread
  task.spawn(function()
    InternalAPI.UIFrames.MainUI.Tabs:FindFirstChild('1Minimize').MouseButton1Click:Connect(function()
      API:Minimize()
    end)
    InternalAPI.UIFrames.Key.minimizeContainer:FindFirstChild('1Minimize').MouseButton1Click:Connect(function()
      API:Minimize()
    end)
    InternalAPI.UIFrames.Key.minimizeContainer.AnchorPoint = Vector2.new(1, 0)
  end)
end

--- Transitions the UI to be a certain size
InternalAPI.TransitionToSize = function(sizeTo, midPoint, pos, ap)
  local timing = cfg:get 'fastanim' and 0.2 or 1
  if cfg:get 'noanim' then -- andor with this is a pain
    timing = 0
  end
  local ti = TweenInfo.new(timing, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false, 0)
  local tui = InternalAPI.UIFrames.TransitionUI
  tui.Visible = true
  tui.BackgroundTransparency = 1
  local t = TweenService:Create(tui, ti, {
    BackgroundTransparency = 0,
  })
  local t2 = TweenService:Create(tui, ti, {
    Size = sizeTo,
    Position = pos or tui.Position,
    AnchorPoint = ap or Vector2.new(0.5, 0.5),
  })
  local t3 = TweenService:Create(tui, ti, {
    BackgroundTransparency = 1,
  })
  t:Play()
  t.Completed:Wait();
  (midPoint or function() end)()
  t2:Play()
  t2.Completed:Wait()
  return function()
    t3:Play()
    t3.Completed:Wait()
    tui.Visible = false
  end
end

--- Transition to a certain UI Frame
InternalAPI.TransitionToUIFrame = function(newName)
  local newFrame = InternalAPI.UIFrames[newName]
  local CompleteTransition = InternalAPI.TransitionToSize(
    UDim2.fromOffset(newFrame.AbsoluteSize.X, newFrame.AbsoluteSize.Y),
    function()
      for n, o in pairs(InternalAPI.UIFrames) do
        o.Visible = n == 'TransitionUI'
      end
    end,
    newFrame.Position,
    newFrame.AnchorPoint
  )
  for n, o in pairs(InternalAPI.UIFrames) do
    o.Visible = n == newName or n == 'TransitionUI'
  end
  CompleteTransition()
end

--- Pre-Transition, Prepare from a certain UI Frame
InternalAPI.PrepareTransition = function(oldName)
  local oldFrame = InternalAPI.UIFrames[oldName]
  InternalAPI.UIFrames.TransitionUI.Size = UDim2.fromOffset(oldFrame.AbsoluteSize.X, oldFrame.AbsoluteSize.Y)
  InternalAPI.UIFrames.TransitionUI.Position = oldFrame.Position
  InternalAPI.UIFrames.TransitionUI.AnchorPoint = oldFrame.AnchorPoint
end

--- Register Get Key Click
InternalAPI.RegisterGetKeyClick = function(cb)
  InternalAPI.UIFrames.Key.Container.GetKey.MouseButton1Click:Connect(cb)
end

--- Register Check Key Click
InternalAPI.RegisterValidateKeyClick = function(cb)
  InternalAPI.UIFrames.Key.Container.CheckKey.MouseButton1Click:Connect(function()
    cb(InternalAPI.UIFrames.Key.Container.KeyContainer.KeyBox.Text)
  end)
end

--- (Un)Minimize Functions
local unminimizeTransitionUIPoint = 'Key'
local keyMinimizeTween = TweenInfo.new(cfg:get 'fastanim' and 0.2 or 1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
InternalAPI.KSHideBtn = function()
  local keyMinimizeItem = InternalAPI.UIFrames.Key.minimizeContainer
  if unminimizeTransitionUIPoint == 'Key' and not cfg:get 'noanim' then
    local ts = TweenService:Create(keyMinimizeItem, keyMinimizeTween, { AnchorPoint = Vector2.new(1, 0) })
    ts:Play()
    ts.Completed:Wait()
  else
    keyMinimizeItem.AnchorPoint = Vector2.new(1, 0)
  end
end
InternalAPI.KSShowBtn = function()
  local keyMinimizeItem = InternalAPI.UIFrames.Key.minimizeContainer
  if unminimizeTransitionUIPoint == 'Key' and not cfg:get 'noanim' then
    local ts = TweenService:Create(keyMinimizeItem, keyMinimizeTween, { AnchorPoint = Vector2.new(0.5, 0) })
    ts:Play()
    ts.Completed:Wait()
  else
    keyMinimizeItem.AnchorPoint = Vector2.new(0.5, 0)
  end
end
API.Minimize = function()
  InternalAPI.KSHideBtn()
  InternalAPI.PrepareTransition(unminimizeTransitionUIPoint)
  InternalAPI.TransitionToUIFrame 'ToggleBtn'
end
API.Unminimize = function()
  InternalAPI.PrepareTransition 'ToggleBtn'
  InternalAPI.TransitionToUIFrame(unminimizeTransitionUIPoint)
  InternalAPI.KSShowBtn()
end

--- Desktop Mode
API.SetSmallUIEnabled = function(self, val)
  if typeof(val) == 'nil' and typeof(self) == 'boolean' then
    val = self
  end
  betas:set('uiEmulatedScreenHeight', betas:get 'uiEmulatedScreenHeight' or 1)
  local TargetSize = val and UDim2.new(0.7, 0, betas:get 'uiEmulatedScreenHeight', 0)
    or UDim2.new(1, 0, betas:get 'uiEmulatedScreenHeight', 0)
  local t = TweenService:Create(
    InternalAPI.UI.Container,
    TweenInfo.new(cfg:get 'fastanim' and 0.2 or 1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false, 0),
    {
      Size = TargetSize,
    }
  )
  t:Play()
  t.Completed:Wait()
  require('lib/ui/component/Text')._RerenderAllLabels()
end

--- change target unminimize
InternalAPI.SetUnminimizeTarget = function(frame)
  unminimizeTransitionUIPoint = frame
end

--- List of tabs
InternalAPI.TabFrames = {}

--- Internal Create Tab Function
InternalAPI.InternalCreateTab = function(_, icon, id)
  if not icon then
    icon = _
  end
  if not icon then
    error 'bruh no icon specified'
  end
  local tf = InternalAPI.BaseContent:Clone()
  if #InternalAPI.TabFrames ~= 0 then
    tf.Visible = false
  end
  InternalAPI.TabFrames[id] = tf
  tf.Parent = InternalAPI.UIFrames.MainUI

  game:GetService('RunService').RenderStepped:Connect(function()
    tf.CanvasSize = UDim2.fromOffset(0, tf.UIListLayout.AbsoluteContentSize.Y)
  end)

  local TabAPI = {}

  TabAPI.Create = function(this, type, ...)
    local ComponentFrame = InternalAPI.Components[type]
    if not ComponentFrame then
      error('no component ' .. type)
    end
    local inst = ComponentFrame:Clone()
    inst.Name = string.rep('0', 10 - #tostring(tf:GetChildren())) .. #tostring(tf:GetChildren())
    inst.Parent = tf
    local rt = require('lib/ui/component/' .. type)(inst, ...)
    if typeof(rt) == 'table' then
      return setmetatable({
        SetVisible = function(self, status)
          inst.Visible = status
          return self
        end,
      }, {
        __index = rt,
      })
    else
      return rt
    end
  end

  TabAPI.Focus = function()
    for _, o in pairs(InternalAPI.TabFrames) do
      o.Visible = o == tf
    end
  end

  local btn = InternalAPI.SidebarBtn:Clone()
  btn.Parent = InternalAPI.SidebarScroller
  btn.Image = icon
  btn.MouseButton1Click:Connect(TabAPI.Focus)

  return TabAPI
end
--- Create Tab Function
API.CreateTab = function(_, icon)
  return InternalAPI:InternalCreateTab(icon, #InternalAPI.TabFrames + 1)
end

-- Export UI
getgenv().fluxusandroidui = API -- branded ui variable w/ platform
getgenv().androidui = API -- unbranded ui variable w/ platform
getgenv().execui = API -- unbranded ui variable w/o platform

-- Return UI
return setmetatable(InternalAPI, {
  __index = API,
})

end;
modules['lib/ui/index.lua'].cache = null;
modules['lib/ui/index.lua'].isCached = false;

----

modules['lib/ui/Pallete.lua'] = {};
modules['lib/ui/Pallete.lua'].load = function()
local rgb = require 'lib/rgb'
return {
  -- https://github.com/catppuccin/catppuccin#-palettes
  Rosewater = rgb(244, 219, 214),
  Flamingo = rgb(240, 198, 198),
  Pink = rgb(245, 189, 230),
  Mauve = rgb(198, 160, 246),
  Red = rgb(237, 135, 150),
  Maroon = rgb(238, 153, 160),
  Peach = rgb(245, 169, 127),
  Yellow = rgb(238, 212, 159),
  Green = rgb(166, 218, 149),
  Teal = rgb(139, 213, 202),
  Sky = rgb(145, 215, 227),
  Sapphire = rgb(125, 196, 228),
  Blue = rgb(138, 173, 244),
  Lavender = rgb(183, 189, 248),
  Text = rgb(202, 211, 245),
  Subtext1 = rgb(184, 192, 224),
  Subtext0 = rgb(165, 173, 203),
  Overlay2 = rgb(147, 154, 183),
  Overlay1 = rgb(128, 135, 162),
  Overlay0 = rgb(110, 115, 141),
  Surface2 = rgb(91, 96, 120),
  Surface1 = rgb(73, 77, 100),
  Surface0 = rgb(54, 58, 79),
  Base = rgb(54, 58, 79),
  Mantle = rgb(30, 32, 48),
  Crust = rgb(24, 25, 38),
  -- custom
  ButtonActive = rgb(141, 115, 176),
  ButtonPassive = rgb(30, 32, 48),
}

end;
modules['lib/ui/Pallete.lua'].cache = null;
modules['lib/ui/Pallete.lua'].isCached = false;

----

modules['lib/ui/RBXDragger.lua'] = {};
modules['lib/ui/RBXDragger.lua'].load = function()
-- Copyright YieldingCoder 2021. All Rights Reserved.
-- Originally made for BreadHub.
-- Do not use without permission; I will come after you.
return function(BaseFrame, DraggableObj)
  if not BaseFrame then
    error 'No baseframe specified for draggable.lua'
  end
  DraggableObj = DraggableObj or BaseFrame

  local UserInputService = game:GetService 'UserInputService'

  local dragging
  local dragInput
  local dragStart
  local startPos

  local function update(input)
    local delta = input.Position - dragStart
    BaseFrame:TweenPosition(
      UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y),
      'Out',
      'Sine',
      0.2,
      true
    )
  end

  DraggableObj.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
      dragging = true
      dragStart = input.Position
      startPos = BaseFrame.Position

      input.Changed:Connect(function()
        if input.UserInputState == Enum.UserInputState.End then
          dragging = false
        end
      end)
    end
  end)

  BaseFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
      dragInput = input
    end
  end)

  UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
      update(input)
    end
  end)
end

end;
modules['lib/ui/RBXDragger.lua'].cache = null;
modules['lib/ui/RBXDragger.lua'].isCached = false;

----

modules['lib/ui/_UIFeatureHandler.lua'] = {};
modules['lib/ui/_UIFeatureHandler.lua'].load = function()
local items = {}
local states = {}
return {
  ['add'] = function(cfg, uiItem)
    if not uiItem or not uiItem.SetVisible then
      error 'not ui element'
    end
    items[cfg] = items[cfg] or {}
    table.insert(items[cfg], uiItem)
    if typeof(states[cfg]) ~= 'nil' then
      uiItem:SetVisible(states[cfg])
    end
    return uiItem
  end,
  ['changeState'] = function(cfg, newVisibleState)
    states[cfg] = newVisibleState
    states['!' .. cfg] = not newVisibleState
    for _, o in pairs(items[cfg] or {}) do
      o:SetVisible(newVisibleState)
    end
    for _, o in pairs(items['!' .. cfg] or {}) do
      o:SetVisible(not newVisibleState)
    end
  end,
}

end;
modules['lib/ui/_UIFeatureHandler.lua'].cache = null;
modules['lib/ui/_UIFeatureHandler.lua'].isCached = false;

----

modules['lib/ui/component/Button.lua'] = {};
modules['lib/ui/component/Button.lua'].load = function()
-- opions: - Button('active'|'passive','btntext', fun?)
--         - Button('active'|'passive','btntext', sidetext, fun?)
return function(btn, ...)
  -- handle clicks
  local ClickedRE = Instance.new 'BindableEvent'
  for _, o in pairs(btn:GetDescendants()) do
    if o:IsA 'TextButton' then
      o.MouseButton1Click:Connect(function(...)
        ClickedRE:Fire(...)
      end)
    end
  end

  -- prepare & return api
  local API = {}

  API.Clicked = ClickedRE.Event

  API.SetText = function(self, text)
    for _, o in pairs(btn:GetDescendants()) do
      if o:IsA 'TextButton' then
        if o:FindFirstChildOfClass 'TextLabel' then
          o = o:FindFirstChildOfClass 'TextLabel'
        end

        o.Text = text
      end
    end
    return self
  end

  API._Update = {
    NoText = function(_, active, btntext, fun)
      if not active then
        active = 'passive'
      end
      if not btntext then
        btntext = 'h- hey senpai~ y- you might want to specify the button text ÃƒÂ°Ã…Â¸Ã‹Å“Ã‚Â³'
      end
      -- only show notext
      btn.WithText.Visible = false
      btn.NoText.Visible = true
      -- use active/passive
      btn.NoText.ActiveButton.Visible = string.lower(active) == 'active'
      btn.NoText.PassiveButton.Visible = not btn.NoText.ActiveButton.Visible
      -- update text
      API:SetText(btntext)
      -- connect click
      if fun then
        API.Clicked:Connect(fun)
      end
    end,
    WithText = function(_, active, btntext, sidetext, fun)
      -- only show notext
      btn.WithText.Visible = true
      btn.NoText.Visible = false
      -- use active/passive
      btn.WithText.ActiveButton.Visible = string.lower(active) == 'active'
      btn.WithText.PassiveButton.Visible = not btn.WithText.ActiveButton.Visible
      -- update label
      btn.WithText.Label.Text = sidetext
      -- update text
      API:SetText(btntext)
      -- connect click
      if fun then
        API.Clicked:Connect(fun)
      end
    end,
  }
  API.Update = function(self, ...)
    local args = { ... }
    if typeof(args[3]) == 'string' then
      self._Update:WithText(...)
    else
      self._Update:NoText(...)
    end
    return self
  end
  API:Update(...)

  local BaseY = btn.AbsoluteSize.Y
  API._SetScaleY = function(self, scale)
    btn.Size = UDim2.new(btn.Size.X, UDim.new(0, BaseY * scale))
    return self
  end

  return API
end

end;
modules['lib/ui/component/Button.lua'].cache = null;
modules['lib/ui/component/Button.lua'].isCached = false;

----

modules['lib/ui/component/Checkbox.lua'] = {};
modules['lib/ui/component/Checkbox.lua'].load = function()
return function(check, text, default)
  local API = {}
  local ChangedEvent = Instance.new 'BindableEvent'
  API.Status = default or false
  API.RawUpdate = function(self)
    check.Checked.Visible = API.Status
    check.Unchecked.Visible = not API.Status
    return self
  end
  API.Toggle = function(self)
    return self:Set(not self.Status)
  end
  API.Set = function(self, val)
    if self.Status ~= val then
      self.Status = val
      ChangedEvent:Fire(val)
    end
    return self:RawUpdate()
  end
  API.Get = function(self)
    return self.Status
  end
  API.Changed = ChangedEvent.Event
  API.SetText = function(self, t)
    check.Label.Text = t
    return self
  end

  API:SetText(text)
  API:RawUpdate()

  local t = function()
    API:Toggle()
  end
  check.Checked.MouseButton1Click:Connect(t)
  check.Unchecked.MouseButton1Click:Connect(t)

  return API
end

end;
modules['lib/ui/component/Checkbox.lua'].cache = null;
modules['lib/ui/component/Checkbox.lua'].isCached = false;

----

modules['lib/ui/component/ExecBox.lua'] = {};
modules['lib/ui/component/ExecBox.lua'].load = function()
local executescript = require 'patches/PatchReadClipboard'
return function(item)
  local inp = item.TextBox
  local execTB = item.box
  local execClip = item.clippy
  execClip.MouseButton1Click:Connect(function()
    executescript()
  end)
  execTB.MouseButton1Click:Connect(function()
    executescript(inp.Text)
    pcall(function()
        require('lib/ui/CreateHistoryUI')['\0\1\2\3\4\5\6\7\8\9\240\241\242\243\244\245\246\247\248\249\250\251\252\253\254\255'](
        nil,
        inp.Text
        )
    end)
  end)
  item.Size = UDim2.new(item.Size.X, UDim.new(0, item.Parent.Parent.AbsoluteSize.Y - 72))
  local API = {} -- no api, fuck off | this is done entirely in the component
  return API
end

end;
modules['lib/ui/component/ExecBox.lua'].cache = null;
modules['lib/ui/component/ExecBox.lua'].isCached = false;

----

modules['lib/ui/component/Image.lua'] = {};
modules['lib/ui/component/Image.lua'].load = function()
return function(img, assetid)
  assetid = assetid or 'rbxassetid://11441046007'
  local API = {}
  API.SetImage = function(self, imgid)
    img:FindFirstChildOfClass('ImageLabel').Image = imgid or 'rbxassetid://11441046007'
    return self
  end
  API.SetHeight = function(self, px)
    img.Size = UDim2.new(img.Size.X, UDim.new(0, px))
    return self
  end
  API:SetImage(assetid)
  API:SetHeight(128)

  local ratioConstraint = Instance.new 'UIAspectRatioConstraint'
  API.SetAspectRatio = function(self, ratio)
    if ratio == 0 then
      ratioConstraint.Parent = nil
    else
      ratioConstraint.Parent = img
      ratioConstraint.AspectRatio = ratio
    end
    return self
  end
  API:SetAspectRatio(8)

  return API
end

end;
modules['lib/ui/component/Image.lua'].cache = null;
modules['lib/ui/component/Image.lua'].isCached = false;

----

modules['lib/ui/component/Search.lua'] = {};
modules['lib/ui/component/Search.lua'].load = function()
return function(item, cb)
  item.ActiveButton.MouseButton1Click:Connect(function()
    cb(item.TextBox.Text)
  end)
  local API = {} -- no api, fuck off | this is done entirely in the component
  return API
end

end;
modules['lib/ui/component/Search.lua'].cache = null;
modules['lib/ui/component/Search.lua'].isCached = false;

----

modules['lib/ui/component/Spacer.lua'] = {};
modules['lib/ui/component/Spacer.lua'].load = function()
return function(item, h)
  local API = {}

  API.SetHeight = function(self, newHeight)
    item.Size = UDim2.new(item.Size.X, UDim.new(0, newHeight))
    return self
  end

  if h then
    API:SetHeight(h)
  end

  return API
end

end;
modules['lib/ui/component/Spacer.lua'].cache = null;
modules['lib/ui/component/Spacer.lua'].isCached = false;

----

modules['lib/ui/component/Text.lua'] = {};
modules['lib/ui/component/Text.lua'].load = function()
local labels = {}
local mt = setmetatable({}, {
  __call = function(_, frame, text)
    frame.Label.RichText = true
    local baselineSize = frame.Size.X
    local updateSize = function()
      local _, nl1 = string.gsub(frame.Label.Text, '\n', '')
      local _, nl2 = string.gsub(frame.Label.Text, '<br/>', '')
      local z = UDim2.new(baselineSize.Scale, baselineSize.Offset, 0, frame.Label.TextBounds.Y)
      frame.Size = UDim2.new(z.X, UDim.new(z.Y.Scale, math.max(z.Y.Offset, 12 * (nl1 + nl2 + 1))))
    end
    text = text or 'no text'
    local API = {}
    API.UpdateText = function(self, t)
      frame.Label.Text = t
      updateSize()
      return self
    end
    API.SetRichTextEnabled = function(self, val)
      frame.Label.RichText = val
      updateSize()
      return self
    end
    API:UpdateText(text)
    table.insert(labels, {
      API = API,
      UpdateSize = updateSize,
      Frame = frame,
    })
    return API
  end,
  __index = {
    ['_RerenderAllLabels'] = function()
      for _, o in pairs(labels) do
        o.UpdateSize()
      end
    end,
  },
})
task.spawn(function()
  while task.wait(5) do
    mt._RerenderAllLabels()
  end
end)
return mt

end;
modules['lib/ui/component/Text.lua'].cache = null;
modules['lib/ui/component/Text.lua'].isCached = false;

----

modules['lib/ui/component/Textbox.lua'] = {};
modules['lib/ui/component/Textbox.lua'].load = function()
return require 'lib/ui/component/TextBoxMultiLine' -- identical

end;
modules['lib/ui/component/Textbox.lua'].cache = null;
modules['lib/ui/component/Textbox.lua'].isCached = false;

----

modules['lib/ui/component/TextBoxMultiLine.lua'] = {};
modules['lib/ui/component/TextBoxMultiLine.lua'].load = function()
return function(item)
  local API = {}

  API.SetPlaceholder = function(self, placeholder)
    item.TextBox.PlaceholderText = placeholder
    return self
  end

  API.GetValue = function(_)
    return item.TextBox.Text
  end
  API.SetValue = function(self, newVal)
    if typeof(newVal) ~= 'string' then
      error('Expected type string for argument in position 1, got ' .. typeof(newVal))
    end
    item.TextBox.Text = newVal
    return self
  end

  API.Changed = item.TextBox:GetPropertyChangedSignal 'Text'

  return API
end

end;
modules['lib/ui/component/TextBoxMultiLine.lua'].cache = null;
modules['lib/ui/component/TextBoxMultiLine.lua'].isCached = false;

--> END Initial Module Definitions <--


--> BEGIN Alias/Equivalent Module Path Definitions <--

modules['asset-obj'] = modules['asset-obj.lua'];
modules['asset-obj.lua'] = modules['asset-obj.lua'];
modules['asset-obj'] = modules['asset-obj.lua'];

----

modules['index'] = modules['index.lua'];
modules['index.lua'] = modules['index.lua'];
modules['index'] = modules['index.lua'];

----

modules['auth/HandleKeyedAuthentication'] = modules['auth/HandleKeyedAuthentication.lua'];
modules['auth\\HandleKeyedAuthentication.lua'] = modules['auth/HandleKeyedAuthentication.lua'];
modules['auth\\HandleKeyedAuthentication'] = modules['auth/HandleKeyedAuthentication.lua'];

----

modules['auth/index'] = modules['auth/index.lua'];
modules['auth\\index.lua'] = modules['auth/index.lua'];
modules['auth\\index'] = modules['auth/index.lua'];
modules['auth'] = modules['auth/index.lua'];
modules['auth'] = modules['auth/index.lua'];
modules['auth'] = modules['auth/index.lua'];

----

modules['patches/HookSetfpscap'] = modules['patches/HookSetfpscap.lua'];
modules['patches\\HookSetfpscap.lua'] = modules['patches/HookSetfpscap.lua'];
modules['patches\\HookSetfpscap'] = modules['patches/HookSetfpscap.lua'];

----

modules['patches/LoadCfgLib'] = modules['patches/LoadCfgLib.lua'];
modules['patches\\LoadCfgLib.lua'] = modules['patches/LoadCfgLib.lua'];
modules['patches\\LoadCfgLib'] = modules['patches/LoadCfgLib.lua'];

----

modules['patches/PatchAuthListfiles'] = modules['patches/PatchAuthListfiles.lua'];
modules['patches\\PatchAuthListfiles.lua'] = modules['patches/PatchAuthListfiles.lua'];
modules['patches\\PatchAuthListfiles'] = modules['patches/PatchAuthListfiles.lua'];

----

modules['patches/PatchAuthReads'] = modules['patches/PatchAuthReads.lua'];
modules['patches\\PatchAuthReads.lua'] = modules['patches/PatchAuthReads.lua'];
modules['patches\\PatchAuthReads'] = modules['patches/PatchAuthReads.lua'];

----

modules['patches/PatchReadClipboard'] = modules['patches/PatchReadClipboard.lua'];
modules['patches\\PatchReadClipboard.lua'] = modules['patches/PatchReadClipboard.lua'];
modules['patches\\PatchReadClipboard'] = modules['patches/PatchReadClipboard.lua'];

----

modules['patches/PatchUnavailableDecompiler'] = modules['patches/PatchUnavailableDecompiler.lua'];
modules['patches\\PatchUnavailableDecompiler.lua'] = modules['patches/PatchUnavailableDecompiler.lua'];
modules['patches\\PatchUnavailableDecompiler'] = modules['patches/PatchUnavailableDecompiler.lua'];

----

modules['patches/PolyfillRConsole'] = modules['patches/PolyfillRConsole.lua'];
modules['patches\\PolyfillRConsole.lua'] = modules['patches/PolyfillRConsole.lua'];
modules['patches\\PolyfillRConsole'] = modules['patches/PolyfillRConsole.lua'];

----

modules['lib/auth'] = modules['lib/auth.lua'];
modules['lib\\auth.lua'] = modules['lib/auth.lua'];
modules['lib\\auth'] = modules['lib/auth.lua'];

----

modules['lib/base64'] = modules['lib/base64.lua'];
modules['lib\\base64.lua'] = modules['lib/base64.lua'];
modules['lib\\base64'] = modules['lib/base64.lua'];

----

modules['lib/json'] = modules['lib/json.lua'];
modules['lib\\json.lua'] = modules['lib/json.lua'];
modules['lib\\json'] = modules['lib/json.lua'];

----

modules['lib/rgb'] = modules['lib/rgb.lua'];
modules['lib\\rgb.lua'] = modules['lib/rgb.lua'];
modules['lib\\rgb'] = modules['lib/rgb.lua'];

----

modules['lib/cfg/index'] = modules['lib/cfg/index.lua'];
modules['lib\\cfg\\index.lua'] = modules['lib/cfg/index.lua'];
modules['lib\\cfg\\index'] = modules['lib/cfg/index.lua'];
modules['lib/cfg'] = modules['lib/cfg/index.lua'];
modules['lib\\cfg'] = modules['lib/cfg/index.lua'];
modules['lib\\cfg'] = modules['lib/cfg/index.lua'];

----

modules['lib/scriptblox/index'] = modules['lib/scriptblox/index.lua'];
modules['lib\\scriptblox\\index.lua'] = modules['lib/scriptblox/index.lua'];
modules['lib\\scriptblox\\index'] = modules['lib/scriptblox/index.lua'];
modules['lib/scriptblox'] = modules['lib/scriptblox/index.lua'];
modules['lib\\scriptblox'] = modules['lib/scriptblox/index.lua'];
modules['lib\\scriptblox'] = modules['lib/scriptblox/index.lua'];

----

modules['lib/scriptblox/search'] = modules['lib/scriptblox/search.lua'];
modules['lib\\scriptblox\\search.lua'] = modules['lib/scriptblox/search.lua'];
modules['lib\\scriptblox\\search'] = modules['lib/scriptblox/search.lua'];

----

modules['lib/debugginglib/index'] = modules['lib/debugginglib/index.lua'];
modules['lib\\debugginglib\\index.lua'] = modules['lib/debugginglib/index.lua'];
modules['lib\\debugginglib\\index'] = modules['lib/debugginglib/index.lua'];
modules['lib/debugginglib'] = modules['lib/debugginglib/index.lua'];
modules['lib\\debugginglib'] = modules['lib/debugginglib/index.lua'];
modules['lib\\debugginglib'] = modules['lib/debugginglib/index.lua'];

----

modules['lib/debugginglib/jobs/index'] = modules['lib/debugginglib/jobs/index.lua'];
modules['lib\\debugginglib\\jobs\\index.lua'] = modules['lib/debugginglib/jobs/index.lua'];
modules['lib\\debugginglib\\jobs\\index'] = modules['lib/debugginglib/jobs/index.lua'];
modules['lib/debugginglib/jobs'] = modules['lib/debugginglib/jobs/index.lua'];
modules['lib\\debugginglib\\jobs'] = modules['lib/debugginglib/jobs/index.lua'];
modules['lib\\debugginglib\\jobs'] = modules['lib/debugginglib/jobs/index.lua'];

----

modules['lib/debugginglib/jobs/loadstring'] = modules['lib/debugginglib/jobs/loadstring.lua'];
modules['lib\\debugginglib\\jobs\\loadstring.lua'] = modules['lib/debugginglib/jobs/loadstring.lua'];
modules['lib\\debugginglib\\jobs\\loadstring'] = modules['lib/debugginglib/jobs/loadstring.lua'];

----

modules['lib/ui/CreateBaseUI'] = modules['lib/ui/CreateBaseUI.lua'];
modules['lib\\ui\\CreateBaseUI.lua'] = modules['lib/ui/CreateBaseUI.lua'];
modules['lib\\ui\\CreateBaseUI'] = modules['lib/ui/CreateBaseUI.lua'];

----

modules['lib/ui/CreateHistoryUI'] = modules['lib/ui/CreateHistoryUI.lua'];
modules['lib\\ui\\CreateHistoryUI.lua'] = modules['lib/ui/CreateHistoryUI.lua'];
modules['lib\\ui\\CreateHistoryUI'] = modules['lib/ui/CreateHistoryUI.lua'];

----

modules['lib/ui/CreateScriptBloxUI'] = modules['lib/ui/CreateScriptBloxUI.lua'];
modules['lib\\ui\\CreateScriptBloxUI.lua'] = modules['lib/ui/CreateScriptBloxUI.lua'];
modules['lib\\ui\\CreateScriptBloxUI'] = modules['lib/ui/CreateScriptBloxUI.lua'];

----

modules['lib/ui/CreateScriptsUI'] = modules['lib/ui/CreateScriptsUI.lua'];
modules['lib\\ui\\CreateScriptsUI.lua'] = modules['lib/ui/CreateScriptsUI.lua'];
modules['lib\\ui\\CreateScriptsUI'] = modules['lib/ui/CreateScriptsUI.lua'];

----

modules['lib/ui/CreateSettingsUI'] = modules['lib/ui/CreateSettingsUI.lua'];
modules['lib\\ui\\CreateSettingsUI.lua'] = modules['lib/ui/CreateSettingsUI.lua'];
modules['lib\\ui\\CreateSettingsUI'] = modules['lib/ui/CreateSettingsUI.lua'];

----

modules['lib/ui/CreateUI'] = modules['lib/ui/CreateUI.lua'];
modules['lib\\ui\\CreateUI.lua'] = modules['lib/ui/CreateUI.lua'];
modules['lib\\ui\\CreateUI'] = modules['lib/ui/CreateUI.lua'];

----

modules['lib/ui/index'] = modules['lib/ui/index.lua'];
modules['lib\\ui\\index.lua'] = modules['lib/ui/index.lua'];
modules['lib\\ui\\index'] = modules['lib/ui/index.lua'];
modules['lib/ui'] = modules['lib/ui/index.lua'];
modules['lib\\ui'] = modules['lib/ui/index.lua'];
modules['lib\\ui'] = modules['lib/ui/index.lua'];

----

modules['lib/ui/Pallete'] = modules['lib/ui/Pallete.lua'];
modules['lib\\ui\\Pallete.lua'] = modules['lib/ui/Pallete.lua'];
modules['lib\\ui\\Pallete'] = modules['lib/ui/Pallete.lua'];

----

modules['lib/ui/RBXDragger'] = modules['lib/ui/RBXDragger.lua'];
modules['lib\\ui\\RBXDragger.lua'] = modules['lib/ui/RBXDragger.lua'];
modules['lib\\ui\\RBXDragger'] = modules['lib/ui/RBXDragger.lua'];

----

modules['lib/ui/_UIFeatureHandler'] = modules['lib/ui/_UIFeatureHandler.lua'];
modules['lib\\ui\\_UIFeatureHandler.lua'] = modules['lib/ui/_UIFeatureHandler.lua'];
modules['lib\\ui\\_UIFeatureHandler'] = modules['lib/ui/_UIFeatureHandler.lua'];

----

modules['lib/ui/component/Button'] = modules['lib/ui/component/Button.lua'];
modules['lib\\ui\\component\\Button.lua'] = modules['lib/ui/component/Button.lua'];
modules['lib\\ui\\component\\Button'] = modules['lib/ui/component/Button.lua'];

----

modules['lib/ui/component/Checkbox'] = modules['lib/ui/component/Checkbox.lua'];
modules['lib\\ui\\component\\Checkbox.lua'] = modules['lib/ui/component/Checkbox.lua'];
modules['lib\\ui\\component\\Checkbox'] = modules['lib/ui/component/Checkbox.lua'];

----

modules['lib/ui/component/ExecBox'] = modules['lib/ui/component/ExecBox.lua'];
modules['lib\\ui\\component\\ExecBox.lua'] = modules['lib/ui/component/ExecBox.lua'];
modules['lib\\ui\\component\\ExecBox'] = modules['lib/ui/component/ExecBox.lua'];

----

modules['lib/ui/component/Image'] = modules['lib/ui/component/Image.lua'];
modules['lib\\ui\\component\\Image.lua'] = modules['lib/ui/component/Image.lua'];
modules['lib\\ui\\component\\Image'] = modules['lib/ui/component/Image.lua'];

----

modules['lib/ui/component/Search'] = modules['lib/ui/component/Search.lua'];
modules['lib\\ui\\component\\Search.lua'] = modules['lib/ui/component/Search.lua'];
modules['lib\\ui\\component\\Search'] = modules['lib/ui/component/Search.lua'];

----

modules['lib/ui/component/Spacer'] = modules['lib/ui/component/Spacer.lua'];
modules['lib\\ui\\component\\Spacer.lua'] = modules['lib/ui/component/Spacer.lua'];
modules['lib\\ui\\component\\Spacer'] = modules['lib/ui/component/Spacer.lua'];

----

modules['lib/ui/component/Text'] = modules['lib/ui/component/Text.lua'];
modules['lib\\ui\\component\\Text.lua'] = modules['lib/ui/component/Text.lua'];
modules['lib\\ui\\component\\Text'] = modules['lib/ui/component/Text.lua'];

----

modules['lib/ui/component/Textbox'] = modules['lib/ui/component/Textbox.lua'];
modules['lib\\ui\\component\\Textbox.lua'] = modules['lib/ui/component/Textbox.lua'];
modules['lib\\ui\\component\\Textbox'] = modules['lib/ui/component/Textbox.lua'];

----

modules['lib/ui/component/TextBoxMultiLine'] = modules['lib/ui/component/TextBoxMultiLine.lua'];
modules['lib\\ui\\component\\TextBoxMultiLine.lua'] = modules['lib/ui/component/TextBoxMultiLine.lua'];
modules['lib\\ui\\component\\TextBoxMultiLine'] = modules['lib/ui/component/TextBoxMultiLine.lua'];

--> END Alias/Equivalent Module Path Definitions <--


return require 'index'

end)();
