require("test/printtable")
require("menu")
require("graph/drawing")
require("level")
require("check")
require("graph/worldcolor")
require("graph/ui")
require("save")
require("readcsv")

gamestate = ""
isMouse = true
version = "1.2.0"
level_num = 122

AllIsVisible = true
AllIsSolve = true
HideUnfinish = false
isDemo = false
steam_running = true
isDebug = false
solve_tot = 0

cursor_normal = love.mouse.newCursor("pic/c1_transparent.png", 16, 16)
cursor_click = love.mouse.newCursor("pic/c2_transparent.png", 16, 16)
cursor_draw = love.mouse.newCursor("pic/c1_transparent.png", 16, 16)

function love.draw()
  if gamestate == "menu" then
    menu.draw()
  elseif gamestate == "ready" or gamestate == "draw" then
    level.draw()
  end
end

function love.keypressed(key)
  print(key)
  if key == "tab" then
    --      local state = not love.mouse.isVisible()
    --      love.mouse.setVisible(state)
  end
  presskey = key
end

screenWidth = 1280
screenHeight = 720

logo_sprite = love.graphics.newImage("pic/Artless.png")
local w, h = logo_sprite:getDimensions()
love.graphics.clear()
love.graphics.draw(logo_sprite, love.graphics.getWidth() / 2 - w / 2, love.graphics.getHeight() / 2 - h / 2, 0, 1, 1)
love.graphics.present()
game_start_time = love.timer.getTime()

presskey = "none"

steam = require("sworks.main")

function steam_init111()
  init_ans = steam.init()
end

function love.load()
  if isDebug ~= true then
    AllIsVisible = false
    AllIsSolve = false
  end
  --	love.window.setFullscreen(true,"desktop")
  font = love.graphics.newFont("Han.otf", 24)
  love.graphics.setFont(font)
  frontcolor = { 255 / 255, 245 / 255, 211 / 255 }
  backcolor = { 249 / 255, 168 / 255, 117 / 255 }
  puzzle_reveal = {}
  puzzle_line = {}
  last_panel = {}
  reveal = {}
  pcall(loadsave)
  menu.load()
  gamestate = "menu"
  love.mouse.setCursor(cursor_normal)
  if steam_running then
    steam_init111()
    if not init_ans then
      print("steam init failed")
      drawDebugText = "steam init failed"
      steam_running = false
    elseif not steam.isConnected() then
      print("steam not connected")
      drawDebugText = "steam not connected"
      steam_running = false
    else
      assert(steam.init() and steam.isRunning(), "Steam client must be running")
      assert(steam.isConnected(), "Steam is in Offline mode")
      user = steam.getUser()
      print("hello " .. user:getName())
      drawDebugText = "hello " .. user:getName()
    end
  end

  now_time = love.timer.getTime()
  print(now_time - game_start_time)
  if now_time - game_start_time < 0.5 then
    love.timer.sleep(0.5 - game_start_time + now_time)
  end

  love.window.setMode(screenWidth, screenHeight, { resizable = true, vsync = false, minwidth = 0, minheight = 0 })
  love.window.setFullscreen(isfullscreen, "desktop")
  --love.window.setFullscreen(true,"desktop")

  --	lib.SteamAPI_Init()
  --	userstats_ptr = lib.SteamUserStats()
end

iiiii = 0
function love.update(dt)
  print(love.timer.getFPS())
  presskey = "none"
  collectgarbage("collect")
  if gamestate == "menu" then
    menu.update()
  elseif gamestate == "ready" or gamestate == "draw" then
    level.update()
  end
end

lastkey = "none"
lastkey_time = -10000

lastclick_time = -10000
function love.mousepressed(x, y, button, isTouch)
  love.mouse.setCursor(cursor_click)
  if gamestate == "menu" then
    menu.mousepressed(x, y, button)
  elseif gamestate == "ready" or gamestate == "draw" then
    level.mousepressed(x, y, button)
  end
  if gamestate ~= "menu" then
    lastclick_time = love.timer.getTime()
  end
end

function love.mousereleased(x, y, button, isTouch)
  if gamestate == "draw" then
    love.mouse.setCursor(cursor_draw)
  else
    love.mouse.setCursor(cursor_normal)
  end
end
