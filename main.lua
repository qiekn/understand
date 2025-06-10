require("global")
require("test/printtable")
require("menu")
require("graph/drawing")
require("level")
require("check")
require("graph/worldcolor")
require("graph/ui")
require("save")
require("readcsv")

------------------------------------------------------------------------
--                          Global Variables                          --
------------------------------------------------------------------------

gamestate = ""
isMouse = true
version = "1.2.0"
level_num = 122

AllIsVisible = true
AllIsSolve = true
HideUnfinish = false
isDemo = false
isDebug = true
solve_tot = 0

cursor_normal = love.mouse.newCursor("assets/images/c1_transparent.png", 16, 16)
cursor_click = love.mouse.newCursor("assets/images/c2_transparent.png", 16, 16)
cursor_draw = love.mouse.newCursor("assets/images/c1_transparent.png", 16, 16)
logo_sprite = love.graphics.newImage("assets/images/Artless.png")

screenWidth = 1280
screenHeight = 720

presskey = "none"
lastkey = "none"
lastkey_time = -10000
lastclick_time = -10000

------------------------------------------------------------------------
--                            Artless Logo                            --
------------------------------------------------------------------------

local w, h = logo_sprite:getDimensions()
love.graphics.clear()
love.graphics.draw(logo_sprite, love.graphics.getWidth() / 2 - w / 2, love.graphics.getHeight() / 2 - h / 2, 0, 1, 1)
love.graphics.present()
game_start_time = love.timer.getTime()

------------------------------------------------------------------------
--                      Löve Callback Functions                       --
------------------------------------------------------------------------

function love.load()
  if isDebug ~= true then
    AllIsVisible = false
    AllIsSolve = false
  end
  --	love.window.setFullscreen(true,"desktop")
  font = love.graphics.newFont(FONT_DIR .. "Han.otf", 24)
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

  now_time = love.timer.getTime()
  print(now_time - game_start_time)
  if now_time - game_start_time < 0.5 then
    love.timer.sleep(0.5 - game_start_time + now_time)
  end

  love.window.setMode(screenWidth, screenHeight, { resizable = true, vsync = false, minwidth = 0, minheight = 0 })
  love.window.setFullscreen(isfullscreen, "desktop")
  --love.window.setFullscreen(true,"desktop")
end

function love.update(dt)
  presskey = "none"
  collectgarbage("collect")
  if gamestate == "menu" then
    menu.update()
  elseif gamestate == "ready" or gamestate == "draw" then
    level.update()
  end
end

function love.draw()
  if gamestate == "menu" then
    menu.draw()
  elseif gamestate == "ready" or gamestate == "draw" then
    level.draw()
  end
end

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

function love.keypressed(key)
  presskey = key
end
