-- wait

newlevel = {}

newlevel.level_str = {
  { "C         S" },
}
newlevel.correct_num = 2

function newlevel.checkVictory()
  correct[currentPanel][1] = isStart("C")
  correct[currentPanel][2] = isEnd("S")
end

function newlevel.LoadLevel()
  delta = 60
  timer = -10000
end

--logo=love.graphics.newImage("pic/logo2.png")

function newlevel.ReplaceDraw()
  mapWidth = mapW[currentPanel]
  mapHeight = mapH[currentPanel]
  screenWidth = love.graphics.getWidth()
  screenHeight = love.graphics.getHeight()
  print(screenWidth, screenHeight)

  scroll = 7
  scrollspeed = 0.2
  if timer == nil then
    delta = 60
    timer = -10000
  end
  if timer == -10000 then
    timer = love.timer.getTime() + 1 / scrollspeed
  end

  scrollsize = scroll * screenHeight
  delta = scrollsize - screenHeight * ((love.timer.getTime() - timer) * scrollspeed)
  if delta < 0 then
    delta = 0
  end
  boxwidth = screenWidth * 0.65 / mapWidth
  if screenHeight / mapHeight * 0.65 < boxwidth then
    boxwidth = screenHeight / mapHeight * 0.65
  end
  if boxwidth > screenWidth / 10 then
    boxwidth = screenWidth / 10
  end
  if boxwidth > screenHeight / 4 then
    boxwidth = screenHeight / 4
  end
  if boxwidth > 200 then
    boxwidth = (200 + boxwidth) / 2
  end
  boxwidth = boxwidth
  linewidth = boxwidth / 20

  if linewidth < 1 then
    linewidth = 1
  end
  mapleft = screenWidth / 2 - boxwidth * (mapWidth + 1) / 2
  maptop = delta + screenHeight / 2 - boxwidth * (mapHeight + 1) / 2

  f2 = min(screenHeight / 18, screenWidth / 18)
  if f2 ~= fontsize then
    fontsize = f2
    font = love.graphics.newFont("Han.otf", fontsize)
    love.graphics.setFont(font)
    font2 = love.graphics.newFont("Han.otf", fontsize / 2)
  end

  --  local w,h=logo:getDimensions()
  love.graphics.setColor(1, 1, 1)
  --  love.graphics.draw(logo,screenWidth/2-w/2,delta-scrollsize-h,0,1,1)
  love.graphics.setColor(frontcolor)
  print(delta)
  drawText(
    screenWidth / 2,
    delta - scrollsize,
    "Understand\n\n\n\nDesign & Code\nArtless\nArtwork & Sound Effect\nArtless\n\n\n\n"
      .. "Playtest\n2jjy   超级大佬   Deusovi\nErzählung.   GENTOVA   落葉子\n墨鱼   塞德莎   Weiyun\n香蕉三千   月囵   zhvsjia\n\n\n\n"
      .. "Thanks\nArtless Games Enrichment Center\n见证者QQ群\n\n\n\n"
      .. "Special Thanks\n2, 4, 6 puzzle\nBaba Is You\nCaterpillar Logic\nLots of Nikoli puzzles\nThe Witness\nMeant To Be A Witness Clone series\nZendo\n\n\n\n"
      .. "Game Engine\nLove2d\n\n\n\nOther Stuffs\nSound Source - MuseScore 3\n思源黑体 - Adobe Fonts\nJSON Encoder & Decoder - Jeffrey Friedl\nSteamworks for Lua/FFI - itraykov\nSilly Fun.mp3 (trailer) - Kevin MacLeod\n\n\n\n"
      .. "Thank you for playing.\n2020, Artless Games\n"
  )

  --  love.graphics.setFont(font2)
  --  drawTextLeft(300,100,"ABCDEFGHIJKLMNOPQRSTUVWXYZ")
  --  drawTextLeft(300,400,"abcdefghijklmnopqrstuvwxyz")
  if newlevel.getColor ~= nil then
    backcolor, frontcolor = newlevel.getColor()
  end

  love.graphics.setBackgroundColor(backcolor)
  love.graphics.setColor(frontcolor)
  love.graphics.setLineStyle("smooth")
  love.graphics.setLineWidth(linewidth)

  for i = 1, mapWidth do
    for j = 1, mapHeight do
      love.graphics.setColor(frontcolor)
      boxX = mapleft + i * boxwidth
      boxY = maptop + j * boxwidth
      if visit_grid[currentPanel][i][j] then
        love.graphics.setColor(midcolor)
        drawSquare(boxX, boxY, boxwidth, true)
        love.graphics.setColor(frontcolor)
      end
      drawSquare(boxX, boxY, boxwidth)
      size = boxwidth
      if newlevel.isFading then
        local p = (currentPanel - 1) / (panel_cnt - 2)
        if p > 1 then
          p = 1
        end
        --        local frontcolor2={frontcolor[1]*(1-p)+backcolor[1]*p,frontcolor[2]*(1-p)+backcolor[2]*p,frontcolor[3]*(1-p)+backcolor[3]*p}
        local frontcolor2 = { frontcolor[1], frontcolor[2], frontcolor[3], 1 - p }
        love.graphics.setColor(frontcolor2)
      end
      if newlevel.HideShape ~= true then
        for k = 1, len(map[currentPanel][i][j].str) do
          local ch = get(map[currentPanel][i][j].str, k)
          if ch == "C" then
            drawCircle(boxX, boxY, size * 0.3, visit_grid[currentPanel][i][j])
          elseif ch == "c" then
            drawCircle(boxX, boxY, size * 0.3, visit_grid[currentPanel][i][j])
            if visit_grid[currentPanel][i][j] then
              love.graphics.setColor(midcolor)
            else
              love.graphics.setColor(backcolor)
            end
            drawCircle(boxX, boxY, size * 0.14, true)
            love.graphics.setColor(frontcolor)
            drawCircle(boxX, boxY, size * 0.15, false)
          elseif ch == "S" then
            drawSquare(boxX, boxY, size * 0.5, visit_grid[currentPanel][i][j])
          elseif ch == "s" then
            drawRect(boxX, boxY, size * 0.25, size * 0.25, math.pi / 4, visit_grid[currentPanel][i][j])
          elseif ch == "U" then
            drawPolygon(boxX, boxY + boxwidth * 0.1, size * 0.3, 3, -math.pi / 2, visit_grid[currentPanel][i][j])
          elseif ch == "L" then
            drawPolygon(boxX + boxwidth * 0.1, boxY, size * 0.3, 3, math.pi, visit_grid[currentPanel][i][j])
          elseif ch == "D" then
            drawPolygon(boxX, boxY - boxwidth * 0.1, size * 0.3, 3, math.pi / 2, visit_grid[currentPanel][i][j])
          elseif ch == "R" then
            drawPolygon(boxX - boxwidth * 0.1, boxY, size * 0.3, 3, 0, visit_grid[currentPanel][i][j])
          elseif ch == "H" then
            drawPolygon(boxX, boxY, size * 0.3, 6, 0, visit_grid[currentPanel][i][j])
          elseif ch == "O" then
            drawStar(boxX, boxY, size * 0.3, 0.8, 8, 0, visit_grid[currentPanel][i][j])
          elseif ch == "T" then
            drawStar(boxX, boxY, size * 0.3, 0.5, 5, -math.pi / 10, visit_grid[currentPanel][i][j])
          elseif ch == "X" then
            drawCross(boxX, boxY, size * 0.3, size * 0.12, 0, visit_grid[currentPanel][i][j])
          elseif ch == "x" then
            drawCross(boxX, boxY, size * 0.3, size * 0.12, math.pi / 4, visit_grid[currentPanel][i][j])
          elseif ch == "u" then
            drawArrow(boxX, boxY, size * 0.3, 1, visit_grid[currentPanel][i][j])
          elseif ch == "l" then
            drawArrow(boxX, boxY, size * 0.3, 2, visit_grid[currentPanel][i][j])
          elseif ch == "d" then
            drawArrow(boxX, boxY, size * 0.3, 3, visit_grid[currentPanel][i][j])
          elseif ch == "r" then
            drawArrow(boxX, boxY, size * 0.3, 4, visit_grid[currentPanel][i][j])
          elseif ch == "N" then
            drawCircle(boxX, boxY, size * 0.3, visit_grid[currentPanel][i][j])
            drawSquare(boxX, boxY, size * 0.5, visit_grid[currentPanel][i][j])
          elseif ch == "@" then
            --print(map[currentPanel][i][j].char)
            drawTetris(boxX, boxY, size * 0.35, alphabet[map[currentPanel][i][j].char], visit_grid[currentPanel][i][j])
          elseif ch == "~" then
            drawTetris(boxX, boxY, size * 0.35, alphabet[map[currentPanel][i][j].num], visit_grid[currentPanel][i][j])
          elseif ch == "#" then
            drawTetris2(boxX, boxY, size * 0.35, tetris[map[currentPanel][i][j].char], visit_grid[currentPanel][i][j])
          elseif ch == "$" then
            drawSprite(boxX, boxY, size * 0.5, newlevel.sprites[map[currentPanel][i][j].sprite])
          end
        end
      end
    end
  end

  love.graphics.setColor(frontcolor)
  love.graphics.setLineWidth(linewidth * 1.5)
  if len(visit[currentPanel]) > 0 then
    x0, y0 = toScreen(visit[currentPanel][1].x, visit[currentPanel][1].y)
    drawSquare(x0, y0, boxwidth * 0.8)
    if len(visit[currentPanel]) >= 2 then
      x1, y1 = toScreen(visit[currentPanel][2].x, visit[currentPanel][2].y)
      pt = { x0 + (x1 - x0) * 0.4, y0 + (y1 - y0) * 0.4, x1, y1 }
      if
        dis(visit[currentPanel][1].x, visit[currentPanel][1].y, visit[currentPanel][2].x, visit[currentPanel][2].y) ~= 1
      then
        pt = { x1, y1 }
      end
      for i = 3, len(visit[currentPanel]) do
        x1, y1 = toScreen(visit[currentPanel][i].x, visit[currentPanel][i].y)
        if
          dis(
            visit[currentPanel][i].x,
            visit[currentPanel][i].y,
            visit[currentPanel][i - 1].x,
            visit[currentPanel][i - 1].y
          ) ~= 1
        then
          if len(pt) >= 4 then
            love.graphics.line(pt)
          end
          pt = { x1, y1 }
        else
          table.insert(pt, x1)
          table.insert(pt, y1)
        end
      end
      if len(pt) >= 4 then
        love.graphics.line(pt)
      end
    end
  end

  love.graphics.setLineWidth(linewidth)
  if level_hint ~= nil then
    if currentPanel == 1 then
      x0, y0 = toScreen(level_hint[1].x, level_hint[1].y)
      drawDottedSquare(x0, y0, boxwidth * 0.4)
      if len(level_hint) >= 2 then
        x1, y1 = toScreen(level_hint[2].x, level_hint[2].y)
        dx = x1 - x0
        dy = y1 - y0
        if dx > 0 then
          dx = 1
        elseif dx < 0 then
          dx = -1
        end
        if dy > 0 then
          dy = 1
        elseif dy < 0 then
          dy = -1
        end
        drawDottedLine(x0 + dx * 0.4 * boxwidth, y0 + dy * 0.4 * boxwidth, x1, y1, boxwidth / 8, boxwidth / 8)
        for i = 3, len(level_hint) do
          x0 = x1
          y0 = y1
          x1, y1 = toScreen(level_hint[i].x, level_hint[i].y)
          drawDottedLine(x0, y0, x1, y1, boxwidth / 8, boxwidth / 8)
        end
      end
    end
  end

  uiSize = math.min(screenWidth / 15, screenHeight / 9)
  line2 = math.min(screenWidth / 120, screenHeight / 80) / 3 * 2
  if line2 < 1 then
    line2 = 1
  end
  love.graphics.setLineWidth(line2)

  uiSize = uiSize * 1.5
  correct_x = screenWidth / 2 - uiSize * (correct_num - 1) / 2
  correct_y = screenHeight - uiSize * 0.6
  drawRoundRect(screenWidth / 2, correct_y + delta, uiSize * (correct_num - 1), uiSize * 0.5, PanelVictory())
  uiSize = uiSize / 1.5

  drawUI()

  correct_x = screenWidth / 2 - uiSize * (correct_num - 1) / 2
  correct_y = screenHeight - uiSize * 0.6

  if currentPanel == panel_cnt then
    if AllVictory() then
      drawStar(screenWidth - uiSize * 0.7, screenHeight / 2 + delta, uiSize / 2, 0.5, 5, -math.pi / 10, true)
    else
      drawStar(screenWidth - uiSize * 0.7, screenHeight / 2 + delta, uiSize / 2, 0.5, 5, -math.pi / 10)
    end
  else
    if PanelVictory() then
      drawPolygon(screenWidth - uiSize * 0.8, screenHeight / 2, uiSize / 2, 3, 0, true)
    else
      drawPolygon(screenWidth - uiSize * 0.8, screenHeight / 2, uiSize / 2, 3, 0, false)
    end
  end

  if gamestate == "draw" then
    display = getlast(visit[currentPanel]).x
    if showcase[display] == nil then
      showcase[display] = love.graphics.newImage("pic/s" .. tonumber(display) .. ".png")
    end
    local w, h = showcase[display]:getDimensions()
    local w0, h0 = showcase[display]:getDimensions()
    if w > love.graphics.getWidth() * 0.7 then
      h = love.graphics.getWidth() * 0.7 / w * h
      w = love.graphics.getWidth() * 0.7
    end
    if h > love.graphics.getHeight() * 0.7 then
      w = love.graphics.getHeight() * 0.7 * w / h
      h = love.graphics.getHeight() * 0.7
    end
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(
      showcase[display],
      love.graphics.getWidth() / 2 - w / 2,
      love.graphics.getHeight() / 2 - h / 2,
      0,
      w / w0,
      h / h0
    )
  end
end

function newlevel.LoadLevel()
  showcase = {}
end

function newlevel.ResetPanel()
  display = 0
end

return newlevel
