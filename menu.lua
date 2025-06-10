-- 菜单系统模块
local menu = {}

-- 全局变量初始化
local gameData = {
  menu_panel = {},
  level_lines = {},
  required_levels = {},
  select = { x = -100, y = -100 },
  fontsize = 0,
  solve_cnt = {},
  level_time = {},
  mute = 0,
  isfullscreen = false,
  mapWidth = 0,
  mapHeight = 0,
  unlocked_world = {},
  unlocked_symbol = {},
}

local ui = {
  uiSize = 0,
  boxwidth = 0,
  linewidth = 0,
  mapleft = 0,
  maptop = 0,
  font = nil,
  font2 = nil,
}

-- 音效资源
local sound_sprite = love.graphics.newImage("assets/images/sound.png")

function menu.load()
  initData()
  loadMapData()
  setupPuzzleReveal()
  calculateSolveCount()
end

-- 初始化游戏数据
function initData()
  gameData.unlocked_world = {}
  gameData.unlocked_symbol = {}
  gamestate = "menu"

  -- 初始化解题计数
  gameData.solve_cnt = {}
  for i = 1, 12 do
    gameData.solve_cnt[i] = 0
  end
end

-- 加载地图数据
function loadMapData()
  gameData.menu_panel = ReadCSV("map.csv")
  gameData.mapWidth = len(gameData.menu_panel[1])
  gameData.mapHeight = len(gameData.menu_panel)

  -- 转置地图数据以适应坐标系
  local transposed = {}
  for i = 1, gameData.mapWidth do
    transposed[i] = {}
    for j = 1, gameData.mapHeight do
      transposed[i][j] = gameData.menu_panel[j][i]
    end
  end
  gameData.menu_panel = transposed
end

-- 设置谜题显示状态
function setupPuzzleReveal()
  for i = 1, gameData.mapWidth do
    if puzzle_reveal[i] == nil then
      puzzle_reveal[i] = {}
    end

    for j = 1, gameData.mapHeight do
      initPuzzleCell(i, j)
      updateUnlockedStatus(i, j)
    end
  end

  -- 处理预设解锁关卡
  processRevealList()

  -- 如果开启全部可见模式
  unlockAllWorlds()
  -- if AllIsVisible then
  --   print("unlock all worlds")
  --   unlockAllWorlds()
  -- end
end

-- 初始化单个谜题格子
function initPuzzleCell(i, j)
  if puzzle_reveal[i][j] == nil then
    puzzle_reveal[i][j] = 0
  end

  local cell = gameData.menu_panel[i][j]
  if cell == "XXX" or cell == "Sound" then
    return
  end

  -- 处理演示模式限制
  if isDemo and isDemoRestricted(cell) then
    gameData.menu_panel[i][j] = "XXX"
    return
  end

  -- 处理起始关卡 1-1
  if cell == "1-1" and puzzle_reveal[i][j] ~= 2 then
    puzzle_reveal[i][j] = 1
    if gameData.select.x < 0 then
      gameData.select.x = i
      gameData.select.y = j
    end
  end

  -- 设置全部可见模式下的状态
  if AllIsVisible and len(cell) >= 3 then
    if puzzle_reveal[i][j] ~= 2 then
      puzzle_reveal[i][j] = 1
      if AllIsSolve then
        puzzle_reveal[i][j] = 2
      end
    end
  end
end

-- 检查演示模式限制
function isDemoRestricted(cell)
  local levelNum = string.match(cell, "%d+")
  return levelNum ~= nil and tonumber(levelNum) >= 4
end

-- 更新解锁状态
function updateUnlockedStatus(i, j)
  if puzzle_reveal[i][j] >= 1 then
    local cell = gameData.menu_panel[i][j]
    local worldNum = string.match(cell, "%d+")

    if worldNum ~= nil then
      gameData.unlocked_world[tonumber(worldNum)] = true
      if puzzle_reveal[i][j] == 2 then
        gameData.unlocked_symbol[tonumber(worldNum)] = true
      end
    end
  end
end

-- 处理预设解锁列表
function processRevealList()
  if len(reveal) > 0 then
    for k = 1, len(reveal) do
      for i = 1, gameData.mapWidth do
        for j = 1, gameData.mapHeight do
          if gameData.menu_panel[i][j] == reveal[k] then
            puzzle_reveal[i][j] = 2
            menu.level_solve(gameData.menu_panel[i][j])
          end
        end
      end
    end
  end
end

-- 解锁所有世界
function unlockAllWorlds()
  for i = 1, 12 do
    gameData.unlocked_world[i] = true
    gameData.unlocked_symbol[i] = true
  end
end

-- 计算解题数量
function calculateSolveCount()
  solve_tot = 0

  for i = 1, gameData.mapWidth do
    for j = 1, gameData.mapHeight do
      local cell = gameData.menu_panel[i][j]

      if puzzle_reveal[i][j] == 2 then
        if cell == "END" then
          solve_tot = solve_tot + 1
        elseif cell ~= "XXX" and len(cell) > 2 and cell ~= "Sound" then
          solve_tot = solve_tot + 1
          local worldNum = string.match(cell, "%d+")
          if worldNum then
            gameData.solve_cnt[tonumber(worldNum)] = gameData.solve_cnt[tonumber(worldNum)] + 1
          end
        end
      end
    end
  end
end

-- 绘制菜单
function menu.draw()
  calculateUILayout()
  setupGraphics()
  drawMenuGrid()
  drawSelection()
  drawUI()

  if isDebug then
    drawTextLeft(100, 100, drawDebugText)
  end
  firstFrame = true
end

-- 计算UI布局
function calculateUILayout()
  local screenWidth = love.graphics.getWidth()
  local screenHeight = love.graphics.getHeight()

  -- 计算可见区域大小
  local maxW, maxH = getVisibleMapSize()

  ui.uiSize = math.min(screenWidth / 15, screenHeight / 9)
  -- TODO: remove this <2025-06-11 02:42, @qiekn> --
  uiSize = ui.uiSize
  ui.boxwidth = calculateBoxSize(screenWidth, screenHeight, maxW, maxH)
  ui.linewidth = math.max(ui.boxwidth / 20, 1)

  ui.mapleft = screenWidth / 2 - ui.boxwidth * (maxW + 1) / 2
  ui.maptop = screenHeight / 2 - ui.boxwidth * (maxH + 1) / 2

  updateFonts()
end

-- 获取可见地图大小
function getVisibleMapSize()
  local maxW, maxH = 1, 1
  for i = 1, gameData.mapWidth do
    for j = 1, gameData.mapHeight do
      if puzzle_reveal[i][j] ~= 0 then
        maxW = math.max(maxW, i)
        maxH = math.max(maxH, j)
      end
    end
  end
  return maxW, maxH
end

-- 计算格子大小
function calculateBoxSize(screenWidth, screenHeight, maxW, maxH)
  local boxwidth = screenWidth * 0.8 / maxW
  boxwidth = math.min(boxwidth, screenHeight / maxH * 0.8)
  boxwidth = math.min(boxwidth, screenWidth / 6)
  boxwidth = math.min(boxwidth, screenHeight / 3)

  if boxwidth > 200 then
    boxwidth = (200 + boxwidth) / 2
  end

  local limit = math.max((screenWidth - ui.uiSize * 7) / maxW, (screenHeight - ui.uiSize * 3) / maxH)
  return math.min(boxwidth, limit)
end

-- 更新字体
function updateFonts()
  local newFontSize = math.max(ui.boxwidth / 4, 2)
  if newFontSize ~= gameData.fontsize then
    gameData.fontsize = newFontSize
    ui.font = love.graphics.newFont(FONT_DIR .. "Han.otf", gameData.fontsize)
    ui.font2 = love.graphics.newFont(FONT_DIR .. "Han.otf", gameData.fontsize * 2)
  end
end

-- 设置图形参数
function setupGraphics()
  love.graphics.setBackgroundColor(backcolor_menu)
  love.graphics.setColor(frontcolor)
  love.graphics.setLineStyle("smooth")
  love.graphics.setLineWidth(ui.linewidth)
  love.graphics.setFont(ui.font)
end

-- 绘制菜单网格
function drawMenuGrid()
  for i = 1, gameData.mapWidth do
    for j = 1, gameData.mapHeight do
      local boxX = ui.mapleft + i * ui.boxwidth
      local boxY = ui.maptop + j * ui.boxwidth
      drawMenuCell(i, j, boxX, boxY)
    end
  end
end

-- 绘制单个菜单格子
function drawMenuCell(i, j, boxX, boxY)
  local cell = gameData.menu_panel[i][j]
  local isVisible = (puzzle_reveal[i][j] ~= 0) or AllIsVisible

  if cell == "XXX" or not isVisible then
    return
  end

  if string.sub(cell, 1, 2) == "EX" then
    drawExtraLevel(boxX, boxY, cell, puzzle_reveal[i][j])
  elseif cell == "END" then
    drawEndLevel(boxX, boxY, puzzle_reveal[i][j])
  elseif string.sub(cell, 1, 1) == "#" then
    -- drawConnectionLine(i, j, boxX, boxY, cell)
  elseif len(cell) <= 2 then
    -- drawSymbolLevel(boxX, boxY, cell)
  elseif cell ~= "Sound" then
    drawNormalLevel(boxX, boxY, cell, puzzle_reveal[i][j])
  end
end

function drawExtraLevel(boxX, boxY, cell, revealStatus)
  local worldNum = tonumber(string.match(cell, "%d+"))
  love.graphics.setColor(midcolors[worldNum])
  drawSquare(boxX, boxY, ui.boxwidth - ui.linewidth + 1, true)

  love.graphics.setColor(frontcolors[worldNum])
  drawSquare(boxX, boxY, ui.boxwidth * 0.7, true)

  love.graphics.setColor(backcolors[worldNum])
  if revealStatus == 2 then
    drawTick(boxX + 0.1 * ui.boxwidth, boxY + 0.06 * ui.boxwidth, ui.boxwidth * 0.25)
  end
  drawText(boxX, boxY, worldNum .. "-?")
end

function drawEndLevel(boxX, boxY, revealStatus)
  love.graphics.setColor(getBackColor("END"))
  drawSquare(boxX, boxY, ui.boxwidth - ui.linewidth + 1, true)

  love.graphics.setColor(getFrontColor("END"))
  drawText(boxX, boxY, "?")

  if revealStatus == 2 then
    drawTick(boxX + 0.1 * ui.boxwidth, boxY + 0.06 * ui.boxwidth, ui.boxwidth * 0.25)
  end
end

function drawNormalLevel(boxX, boxY, cell, revealStatus)
  love.graphics.setColor(getMidColor(cell))
  drawSquare(boxX, boxY, ui.boxwidth - ui.linewidth + 1, true)

  love.graphics.setColor(getBackColor(cell))
  drawSquare(boxX, boxY, ui.boxwidth * 0.7, true)

  love.graphics.setColor(getFrontColor(cell))
  drawSquare(boxX, boxY, ui.boxwidth * 0.7, false)

  if revealStatus == 2 then
    drawTick(boxX + 0.1 * ui.boxwidth, boxY + 0.06 * ui.boxwidth, ui.boxwidth * 0.25)
  end
  drawText(boxX, boxY, cell)
end

function drawSelection()
  local boxX = ui.mapleft + gameData.select.x * ui.boxwidth
  local boxY = ui.maptop + gameData.select.y * ui.boxwidth
  love.graphics.setColor(0, 0, 0)
  drawSquare(boxX, boxY, ui.boxwidth, false)
end

function menu.mousepressed(mx, my, button)
  if not firstFrame or button ~= 1 then
    return
  end

  -- local functions
  local function isValidGridClick(x, y)
    return x > 0 and y > 0 and x <= gameData.mapWidth and y <= gameData.mapHeight
  end
  local function handleGridClick(x, y)
    local cell = gameData.menu_panel[x][y]
    if cell == "XXX" or len(cell) <= 2 then
      return
    end
    if puzzle_reveal[x][y] >= 1 then
      gameData.select = { x = x, y = y }
      currentLevel = cell
      level.loadlevel()
    end
  end
  local function handleUIClick(x, y)
    local screenWidth = love.graphics.getWidth()
    local function toggleMute() -- 切换静音
      if gameData.mute <= 0 then
        gameData.mute = 2
      else
        gameData.mute = gameData.mute - 1
      end

      if gameData.mute ~= 2 then
        stopsound()
        src5:play()
      end
      save()
    end
    local function toggleFullscreen() -- 切换全屏
      gameData.isfullscreen = not gameData.isfullscreen
      love.window.setFullscreen(gameData.isfullscreen, "desktop")
      save()
    end
    local function handleQuitClick() -- 处理退出点击
      if love.timer.getTime() - lastclick_time > 0.25 then
        love.event.push("quit")
      end
    end

    if x > screenWidth - ui.uiSize * 1.2 and y <= ui.uiSize * 1.2 then
      handleQuitClick()
    elseif x > screenWidth - ui.uiSize * 2.2 and y <= ui.uiSize * 1.2 then
      toggleFullscreen()
    elseif x > screenWidth - ui.uiSize * 3.2 and y <= ui.uiSize * 1.2 then
      toggleMute()
    end
  end

  -- main logic
  local clickedX = math.floor((mx - ui.mapleft) / ui.boxwidth + 0.5)
  local clickedY = math.floor((my - ui.maptop) / ui.boxwidth + 0.5)

  if isValidGridClick(clickedX, clickedY) then
    handleGridClick(clickedX, clickedY)
  else
    handleUIClick(x, y)
  end
end

-- 关卡完成处理
function menu.level_solve(levelName)
  markLevelSolved(levelName)
  -- revealAdjacentLevels(levelName)
  calculateSolveCount()
end

-- 标记关卡为已解决
function markLevelSolved(levelName)
  for i = 1, gameData.mapWidth do
    for j = 1, gameData.mapHeight do
      if gameData.menu_panel[i][j] == levelName then
        puzzle_reveal[i][j] = 2
        local worldNum = string.match(levelName, "%d+")
        if worldNum then
          gameData.unlocked_symbol[tonumber(worldNum)] = true
        end

        -- 显示相邻关卡
        reveal_level(i, j - 1, levelName)
        reveal_level(i, j + 1, levelName)
        reveal_level(i - 1, j, levelName)
        reveal_level(i + 1, j, levelName)
      end
    end
  end
end

-- 显示相邻关卡
function reveal_level(w, h, solvedLevel)
  if w <= 0 or h <= 0 or w > gameData.mapWidth or h > gameData.mapHeight then
    return
  end

  local cell = gameData.menu_panel[w][h]
  if cell == "XXX" or cell == "Sound" or len(cell) <= 2 then
    return
  end

  local solvedWorldNum = tonumber(string.match(solvedLevel, "%d+"))
  if not solvedWorldNum then
    return
  end

  if puzzle_reveal[w][h] == 0 then
    if cell == "END" then
      puzzle_reveal[w][h] = 1
    else
      local cellWorldNum = tonumber(string.match(cell, "%d+"))
      if cellWorldNum and solvedWorldNum >= cellWorldNum then
        puzzle_reveal[w][h] = 1
        gameData.unlocked_world[cellWorldNum] = true
      end
    end
  end
end

-- 重置菜单状态
function menu.re()
  gamestate = "menu"
  gameData.mapWidth = len(gameData.menu_panel)
  gameData.mapHeight = len(gameData.menu_panel[1])
  save()
end

return menu
