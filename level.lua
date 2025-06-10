require("graph/alphabet")
local menu = require("menu")

level = {}
visit = {}
visit_grid = {}
correct = {}
--[[
World 1: Basic
World 2: Value
World 3: Area
World 4: Shape
World 5: Number
World 6: Symmetry
World 7: Arrow
World 8: Polyomino
World 9: Turn
World 10: Mix
]]
src1 = love.audio.newSource("assets/audio/positive.ogg", "static")
src2 = love.audio.newSource("assets/audio/negative.ogg", "static")
src3 = love.audio.newSource("assets/audio/win.ogg", "static")
src4 = love.audio.newSource("assets/audio/strongnegative.ogg", "static")
src5 = love.audio.newSource("assets/audio/levelstart.ogg", "static")
src6 = love.audio.newSource("assets/audio/reset.ogg", "static")

fullscreen_sprite = love.graphics.newImage("assets/images/fullscreen1.png")
fullscreen_sprite2 = love.graphics.newImage("assets/images/fullscreen2.png")
sound_sprite = love.graphics.newImage("assets/images/sound.png")

--default_hint_time=-1000

src1:setVolume(0.15)
src2:setVolume(0.2)
src3:setVolume(0.2)
src4:setVolume(0.2)
src5:setVolume(0.15)
src6:setVolume(0.1)

cursor = love.mouse.newCursor("assets/images/cursor.png", 16, 16)

function stopsound(src)
  if mute == 0 then
    src1:setVolume(0.15)
    src2:setVolume(0.2)
    src3:setVolume(0.2)
    src4:setVolume(0.2)
    src5:setVolume(0.15)
    src6:setVolume(0.1)
  end
  if mute == 1 then
    src1:setVolume(0.075)
    src2:setVolume(0.1)
    src3:setVolume(0.1)
    src4:setVolume(0.1)
    src5:setVolume(0.075)
    src6:setVolume(0.05)
  end
  src1:stop()
  src2:stop()
  src3:stop()
  src4:stop()
  src5:stop()
  src6:stop()
end

levels = {}

function level.loadlevel()
  stopsound()
  if mute ~= 2 then
    src5:play()
  end

  err = ""
  if level_time[currentLevel] == nil then
    level_time[currentLevel] = {}
    level_time[currentLevel]["start"] = love.timer.getTime()
  end
  str = currentLevel
  --Read file
  --[[  package.loaded["level/"..str] = nil
  status,err=pcall(function()
    require("level/"..str)
  end)
  --So Dumb
  if not status then
    err0=err
    ans=string.find(err,"not found")
    if(ans==nil)then
      require("level/"..str)
    end
    return
  end]]
  levels[str] = require("level/" .. str)
  newlevel0 = levels[str]
  level_str = newlevel0.level_str
  panel_cnt = len(level_str)
  level_hint = newlevel0.hint
  correct_num = newlevel0.correct_num
  if newlevel0.time ~= nil then
    --showhint_time=newlevel0.time
  else
    --showhint_time=default_hint_time
  end
  showhint = -10000
  if get(currentLevel, len(currentLevel)) == "'" then
    frontcolor = getBackColor(currentLevel)
    backcolor = getFrontColor(currentLevel)
    midcolor = getMidColor(currentLevel)
  else
    backcolor = getBackColor(currentLevel)
    frontcolor = getFrontColor(currentLevel)
    midcolor = getMidColor(currentLevel)
  end
  visit = {}
  visit_grid = {}
  for i = 1, panel_cnt do
    visit[i] = {}
    visit_grid[i] = {}
    correct[i] = {}
  end
  currentPanel = 1
  ResetAllPanel()

  currentPanel = 1
  if newlevel0.LoadLevel ~= nil then
    newlevel0.LoadLevel()
    print("load level")
  end

  if newlevel0.curve ~= nil then
    curve = newlevel0.curve
  end

  if level_lines[currentLevel] ~= nil then
    for i = 1, panel_cnt do
      if level_lines[currentLevel][i] ~= nil and len(level_lines[currentLevel][i]) > 0 then
        visit[i] = {}
        currentPanel = i
        for j = 1, len(level_lines[currentLevel][i]) do
          table.insert(visit[i], { x = level_lines[currentLevel][i][j].x, y = level_lines[currentLevel][i][j].y })
          if visit_grid[currentPanel][level_lines[currentLevel][i][j].x] == nil then
            visit_grid[currentPanel][level_lines[currentLevel][i][j].x] = {}
          end
          visit_grid[currentPanel][level_lines[currentLevel][i][j].x][level_lines[currentLevel][i][j].y] = true
        end
        local able = true
        for j = 1, len(visit[currentPanel]) do
          if currentLevel ~= "EX-1" then
            if visit[currentPanel][j].x > mapW[currentPanel] or visit[currentPanel][j].y > mapH[currentPanel] then
              able = false
            end
          end
        end
        if not able then
          ResetPanel()
        else
          if newlevel0.LoadLine ~= nil then
            newlevel0.LoadLine()
          end
          status, err = pcall(function()
            newlevel0.checkVictory()
          end)
          if not status then
            ResetPanel()
          end
        end
      end
    end
    currentPanel = 1
  else
    level_lines[currentLevel] = {}
  end
  if last_panel[currentLevel] == nil then
    last_panel[currentLevel] = 1
  end

  --  currentPanel=last_panel[currentLevel]
  --  if currentPanel>panel_cnt then
  --
  --  while currentPanel<=panel_cnt and PanelVictory(currentPanel) do
  --    currentPanel=currentPanel+1
  --  end
  --  if currentPanel==panel_cnt+1 then
  --    currentPanel=1
  --  end
end

function level.draw()
  if newlevel0.ReplaceDraw ~= nil then
    newlevel0.ReplaceDraw()
    return
  end

  mapWidth = mapW[currentPanel]
  mapHeight = mapH[currentPanel]
  screenWidth = love.graphics.getWidth()
  screenHeight = love.graphics.getHeight()

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
  maptop = screenHeight / 2 - boxwidth * (mapHeight + 1) / 2

  if newlevel0.SpecialDrawSetting ~= nil then
    --print("?")
    newlevel0.SpecialDrawSetting()
  end

  if math.min(screenWidth / 24, screenHeight / 15) ~= fontsize then
    fontsize = math.min(screenWidth / 24, screenHeight / 15)
    if fontsize < 2 then
      fontsize = 2
    end
    font = love.graphics.newFont(FONT_DIR .. "han.otf", fontsize)
    love.graphics.setFont(font)
    font2 = love.graphics.newFont(FONT_DIR .. "Han.otf", fontsize / 2)
  end

  love.graphics.setFont(font)
  --  love.graphics.setFont(font2)
  --  drawTextLeft(300,100,"ABCDEFGHIJKLMNOPQRSTUVWXYZ")
  --  drawTextLeft(300,400,"abcdefghijklmnopqrstuvwxyz")
  if newlevel0.getColor ~= nil then
    backcolor, frontcolor = newlevel0.getColor()
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
      if newlevel0.drawGrid ~= false then
        drawSquare(boxX, boxY, boxwidth)
      else
        local frontcolor2 = { frontcolor[1], frontcolor[2], frontcolor[3], 0 }
        love.graphics.setColor(frontcolor2)
      end
      size = boxwidth
      if newlevel0.isFading then
        local p = (currentPanel - 1) / (panel_cnt - 2)
        if p > 1 then
          p = 1
        end
        local frontcolor2 = { frontcolor[1], frontcolor[2], frontcolor[3], 1 - p }
        love.graphics.setColor(frontcolor2)
      end
      if newlevel0.HideShape ~= true then
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
          elseif ch == "=" then
            drawSmallLine(
              boxX,
              boxY,
              size,
              newlevel0.curve[map[currentPanel][i][j].char],
              visit_grid[currentPanel][i][j]
            )
          elseif ch == "$" then
            drawSprite(boxX, boxY, size * 0.5, newlevel0.sprites[map[currentPanel][i][j].sprite])
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

  if get(currentLevel, 1, 2) == "EX" then
    local ans = string.match(currentLevel, "%d+")
    drawTextLeft(fontsize / 2, fontsize / 2, ans .. "-?-" .. currentPanel)
  elseif get(currentLevel, 1, 2) == "END" then
  else
    drawTextLeft(fontsize / 2, fontsize / 2, currentLevel .. "-" .. currentPanel)
  end

  line2 = math.min(screenWidth / 120, screenHeight / 80) / 3 * 2
  if line2 < 1 then
    line2 = 1
  end
  love.graphics.setLineWidth(line2)

  uiSize = math.min(screenWidth / 15, screenHeight / 9)
  uiSize = uiSize * 1.5
  correct_x = screenWidth / 2 - uiSize * (correct_num - 1) / 2
  correct_y = screenHeight - uiSize * 0.5

  if currentPanel == panel_cnt and newlevel0.WIP ~= true then
    --    drawRect(screenWidth/2,correct_y,100*correct_num/2-30,25,0,PanelVictory())
    drawRoundRect(screenWidth / 2, correct_y, uiSize * (correct_num - 1), uiSize * 0.5, PanelVictory())
  else
    for i = 1, correct_num do
      love.graphics.setColor(frontcolor)
      if newlevel0.CircleColor ~= nil then
        love.graphics.setFont(font2)
        if currentLevel == "EX-10" then
          love.graphics.setColor(frontcolors[currentPanel])
          drawCircle(correct_x + (i - 1) * uiSize, correct_y, uiSize * 0.25, correct[currentPanel][i])
          drawText(correct_x + (i - 1) * uiSize, correct_y + fontsize / 4, tostring(currentPanel))
        elseif type(newlevel0.CircleColor[i]) == "number" then
          love.graphics.setColor(frontcolors[newlevel0.CircleColor[i]])
          drawCircle(correct_x + (i - 1) * uiSize, correct_y, uiSize * 0.25, correct[currentPanel][i])
          drawText(correct_x + (i - 1) * uiSize, correct_y + fontsize / 4, tostring(newlevel0.CircleColor[i]))
        elseif type(newlevel0.CircleColor[i]) == "table" then
          love.graphics.setColor(frontcolors[newlevel0.CircleColor[i][1]])
          love.graphics.arc(
            "fill",
            correct_x + (i - 1) * uiSize,
            correct_y,
            uiSize * 0.25 + math.min(screenWidth / 120, screenHeight / 80) / 2,
            math.pi / 2,
            math.pi * 3 / 2
          )
          love.graphics.setColor(frontcolors[newlevel0.CircleColor[i][2]])
          love.graphics.arc(
            "fill",
            correct_x + (i - 1) * uiSize,
            correct_y,
            uiSize * 0.25 + math.min(screenWidth / 120, screenHeight / 80) / 2,
            -math.pi / 2,
            math.pi / 2
          )
          if correct[currentPanel][i] == false then
            love.graphics.setColor(backcolor)
            love.graphics.circle(
              "fill",
              correct_x + (i - 1) * uiSize,
              correct_y,
              uiSize * 0.25 - math.min(screenWidth / 120, screenHeight / 80) / 2
            )
            love.graphics.setColor(frontcolors[newlevel0.CircleColor[i][1]])
            local pt = {}
            local mm = ((math.min(screenWidth / 120, screenHeight / 80) - 2) / uiSize) / 2
            for t = 0, 100 do
              table.insert(
                pt,
                correct_x + (i - 1) * uiSize - uiSize * 0.25 * math.sin(mm / 2 + (math.pi - mm) * t / 100)
              )
              table.insert(pt, correct_y + uiSize * 0.25 * math.cos(mm / 2 + (math.pi - mm) * t / 100))
            end
            --            love.graphics.line(pt)
            drawText(correct_x + (i - 1.1) * uiSize, correct_y + fontsize / 4, tostring(newlevel0.CircleColor[i][1]))
            love.graphics.setColor(frontcolors[newlevel0.CircleColor[i][2]])
            local pt = {}
            for t = 0, 100 do
              table.insert(
                pt,
                correct_x + (i - 1) * uiSize + uiSize * 0.25 * math.sin(mm / 2 + (math.pi - mm) * t / 100)
              )
              table.insert(pt, correct_y + uiSize * 0.25 * math.cos(mm / 2 + (math.pi - mm) * t / 100))
            end
            --            love.graphics.line(pt)
            drawText(correct_x + (i - 0.9) * uiSize, correct_y + fontsize / 4, tostring(newlevel0.CircleColor[i][2]))
          end
        else
          drawCircle(correct_x + (i - 1) * uiSize, correct_y, uiSize * 0.25, correct[currentPanel][i])
        end
      else
        drawCircle(correct_x + (i - 1) * uiSize, correct_y, uiSize * 0.25, correct[currentPanel][i])
      end
    end
  end

  uiSize = uiSize / 1.5

  love.graphics.setColor(frontcolor)
  if currentPanel == 1 then
  --    drawPolygon(70,screenHeight-200,50,3,math.pi,true)
  else
    local ans = true
    for i = 1, currentPanel - 1 do
      if not PanelVictory(i) then
        ans = false
      end
    end
    drawPolygon(uiSize * 0.8, screenHeight / 2, uiSize / 2, 3, math.pi, ans)
  end

  drawUI()

  if currentPanel == panel_cnt then
    if AllVictory() then
      drawStar(screenWidth - uiSize * 0.7, screenHeight / 2, uiSize / 2, 0.5, 5, -math.pi / 10, true)
    else
      drawStar(screenWidth - uiSize * 0.7, screenHeight / 2, uiSize / 2, 0.5, 5, -math.pi / 10)
    end
  else
    if PanelVictory() then
      drawPolygon(screenWidth - uiSize * 0.8, screenHeight / 2, uiSize / 2, 3, 0, true)
    else
      drawPolygon(screenWidth - uiSize * 0.8, screenHeight / 2, uiSize / 2, 3, 0, false)
    end
  end

  --  if love.timer.getTime()-loadleveltime>showhint_time then
  --    if love.timer.getTime()-loadleveltime<showhint_time+5 then
  --      love.graphics.setColor(frontcolor[1],frontcolor[2],frontcolor[3],(love.timer.getTime()-loadleveltime-showhint_time)/5)
  --    end
  --    drawSquare(screenWidth-uiSize*1.7,uiSize*0.7,uiSize*0.8,false)
  --    drawTextLeft(screenWidth-uiSize*1.7-fontsize*0.25,fontsize*0.65,"?")
  --  end

  if newlevel0.SpecialDraw ~= nil then
    newlevel0.SpecialDraw()
  end
end

function AllVictory()
  for i = 1, panel_cnt do
    for j = 1, correct_num do
      if correct[i][j] ~= true then
        return false
      end
    end
  end
  if puzzle_reveal[select.x][select.y] ~= 2 then
    puzzle_reveal[select.x][select.y] = 2
    if level_time[currentLevel]["end"] == nil then
      level_time[currentLevel]["end"] = love.timer.getTime()
    end
    save()
  end
  return true
end

function PanelVictory(panel)
  if panel ~= nil then
    for j = 1, correct_num do
      if correct[panel][j] ~= true then
        return false
      end
    end
    return true
  end
  for j = 1, correct_num do
    if correct[currentPanel][j] ~= true then
      return false
    end
  end
  return true
end

function PanelFail(panel)
  if panel ~= nil then
    for j = 1, correct_num do
      if correct[panel][j] == true then
        return false
      end
    end
    return true
  end
  for j = 1, correct_num do
    if correct[currentPanel][j] == true then
      return false
    end
  end
  return true
end

showhint = -10000

function level.update()
  local x = love.mouse.getX()
  local y = love.mouse.getY()
  if
    (love.timer.getTime() - showhint <= 0.5)
    and (x > screenWidth - uiSize * 2.2)
    and (x < screenWidth - uiSize * 1.4)
    and (y <= uiSize * 1.2)
  then
    showhint = love.timer.getTime()
  end
  if gamestate == "draw" then
    --    if love.timer.getTime()-mousedelay<0.05 then
    --    return
    --  end
    if newlevel0.mouseDraw ~= nil then
      newlevel0.mouseDraw()
      return
    end
    lastpos = getlast(visit[currentPanel])
    local x1 = love.mouse.getX()
    local y1 = love.mouse.getY()
    local x2, y2 = toScreen(lastpos.x, lastpos.y)
    local xx = math.floor((x1 - mapleft) / boxwidth + 0.5)
    local yy = math.floor((y1 - maptop) / boxwidth + 0.5)
    if math.abs(x1 - x2) > math.abs(y1 - y2) then
      if xx > lastpos.x then
        xx = lastpos.x + 1
        yy = lastpos.y
      elseif xx < lastpos.x then
        xx = lastpos.x - 1
        yy = lastpos.y
      end
    elseif math.abs(x1 - x2) < math.abs(y1 - y2) then
      if yy > lastpos.y then
        yy = lastpos.y + 1
        xx = lastpos.x
      elseif yy < lastpos.y then
        yy = lastpos.y - 1
        xx = lastpos.x
      end
    end
    if (xx > 0) and (yy > 0) and (xx <= mapWidth) and (yy <= mapHeight) then
      if dis(xx, yy, lastpos.x, lastpos.y) == 1 then
        if not visit_grid[currentPanel][xx][yy] then
          visit_grid[currentPanel][xx][yy] = true
          table.insert(visit[currentPanel], { x = xx, y = yy })
        else
          if
            (visit[currentPanel][len(visit[currentPanel]) - 1].x == xx)
            and (visit[currentPanel][len(visit[currentPanel]) - 1].y == yy)
          then
            visit_grid[currentPanel][lastpos.x][lastpos.y] = false
            table.remove(visit[currentPanel])
          end
        end
      end
    end
  end
end

local last_visit = {}

function level.mousepressed(x, y, button)
  if gamestate == "ready" then
    if button == 1 then
      xx = math.floor((x - mapleft) / boxwidth + 0.5)
      yy = math.floor((y - maptop) / boxwidth + 0.5)
      if
        (x < uiSize * 1.2)
        and (y >= screenHeight / 2 - uiSize)
        and (y <= screenHeight / 2 + uiSize)
        and (currentPanel > 1)
      then
        currentPanel = currentPanel - 1
        mapWidth = mapW[currentPanel]
        mapHeight = mapH[currentPanel]
        last_panel[currentLevel] = currentPanel
      elseif
        (x > screenWidth - uiSize * 1.2)
        and (y >= screenHeight / 2 - uiSize)
        and (y <= screenHeight / 2 + uiSize)
        and (currentPanel <= panel_cnt)
      then
        currentPanel = currentPanel + 1
        if currentPanel > panel_cnt then
          if AllVictory() then
            menu.level_solve(currentLevel)
            menu.re()
          else
            currentPanel = panel_cnt
          end
        else
          mapWidth = mapW[currentPanel]
          mapHeight = mapH[currentPanel]
        end
        last_panel[currentLevel] = currentPanel
      elseif (x > screenWidth - uiSize * 1.2) and (y <= uiSize * 1.2) then
        if AllVictory() then
          menu.level_solve(currentLevel)
        end
        menu.re()
      elseif (x > screenWidth - uiSize * 2.2) and (y <= uiSize * 1.2) then
        isfullscreen = not isfullscreen
        love.window.setFullscreen(isfullscreen, "desktop")
        save()
      elseif (x > screenWidth - uiSize * 3.2) and (y <= uiSize * 1.2) then
        if mute <= 0 then
          mute = 2
        else
          mute = mute - 1
        end
        if mute ~= 2 then
          stopsound()
          src5:play()
        end
        save()
      elseif (xx > 0) and (yy > 0) and (xx <= mapWidth) and (yy <= mapHeight) then
        if visit[currentPanel] == nil or len(visit[currentPanel]) <= 0 then
          last_visit = {}
        else
          last_visit = {}
          for i = 1, len(visit[currentPanel]) do
            last_visit[i] = visit[currentPanel][i]
          end
        end
        ResetPanel()
        visit[currentPanel] = { { x = xx, y = yy } }
        visit_grid[currentPanel][xx][yy] = true
        gamestate = "draw"
        --    love.mouse.setCursor(cursor)
      end
    elseif button == 2 then
      xx = math.floor((x - mapleft) / boxwidth + 0.5)
      yy = math.floor((y - maptop) / boxwidth + 0.5)
      if (xx > 0) and (yy > 0) and (xx <= mapWidth) and (yy <= mapHeight) then
        ResetPanel()
        level_lines[currentLevel][currentPanel] = {}
        stopsound()
        if mute ~= 2 then
          src6:play()
        end
      end
    end
  --    if(x>screenWidth-uiSize*2.2)and(x<screenWidth-uiSize*1.4)and(y<=uiSize*1.2)and(love.timer.getTime()-loadleveltime>showhint_time)then
  --      showhint=love.timer.getTime()
  --    end
  elseif gamestate == "draw" then
    if button == 1 then
      gamestate = "ready"
      --  love.mouse.setCursor()
      newlevel0.checkVictory()
      if level_lines[currentLevel] == nil then
        level_lines[currentLevel] = {}
        for i = 1, panel_cnt do
          table.insert(level_lines[currentLevel], {})
        end
      end
      level_lines[currentLevel][currentPanel] = {}
      for i = 1, len(visit[currentPanel]) do
        table.insert(
          level_lines[currentLevel][currentPanel],
          { x = visit[currentPanel][i].x, y = visit[currentPanel][i].y }
        )
      end
      save()
      if mute ~= 2 then
        if AllVictory() then
          stopsound()
          src3:play()
        elseif PanelVictory() then
          stopsound()
          src1:play()
        elseif PanelFail() then
          stopsound()
          src4:play()
        else
          stopsound()
          src2:play()
        end
      end
    elseif button == 2 then
      gamestate = "ready"
      ResetPanel()
      if last_visit ~= nil and len(last_visit) > 0 then
        for i = 1, len(last_visit) do
          table.insert(visit[currentPanel], last_visit[i])
          if visit_grid[currentPanel][last_visit[i].x] == nil then
            visit_grid[currentPanel][last_visit[i].x] = {}
          end
          visit_grid[currentPanel][last_visit[i].x][last_visit[i].y] = true
        end
        newlevel0.checkVictory()
        stopsound()
        if mute ~= 2 then
          if AllVictory() then
            stopsound()
            src3:play()
          elseif PanelVictory() then
            stopsound()
            src1:play()
          elseif PanelFail() then
            stopsound()
            src4:play()
          else
            stopsound()
            src2:play()
          end
        end
      else
        stopsound()
        if mute ~= 2 then
          src6:play()
        end
      end
    end
  end
end

function ResetPanel()
  correct[currentPanel] = {}
  for i = 1, correct_num do
    correct[currentPanel][i] = false
  end
  visit[currentPanel] = {}
  visit_grid[currentPanel] = {}
  for i = 1, mapW[currentPanel] do
    visit_grid[currentPanel][i] = {}
    for j = 1, mapH[currentPanel] do
      visit_grid[currentPanel][i][j] = false
    end
  end
  if newlevel0.ResetPanel ~= nil then
    newlevel0.ResetPanel()
  end
end

function ResetAllPanel()
  mapW = {}
  mapH = {}
  map = {}
  for i = 1, panel_cnt do
    currentPanel = i
    LoadPanel()
    ResetPanel()
  end
  currentPanel = 1
  mapWidth = mapW[1]
  mapHeight = mapH[1]
end

function LoadPanel()
  map_str = level_str[currentPanel]
  mapWidth = 0
  for i = 1, len(map_str[1]) do
    ans = string.find(get(map_str[1], i), "[@#$=~]")
    if ans == nil then
      mapWidth = mapWidth + 1
    end
  end
  mapHeight = len(map_str)
  mapW[currentPanel] = mapWidth
  mapH[currentPanel] = mapHeight
  map[currentPanel] = {}
  for i = 1, mapHeight do
    p = 1
    for j = 1, mapWidth do
      if map[currentPanel][j] == nil then
        map[currentPanel][j] = {}
      end
      obj = {}
      obj.str = get(map_str[i], p)
      if obj.str == "." or obj.str == "" then
        obj.str = " "
      end
      p = p + 1
      if obj.str == "@" then
        obj.char = get(map_str[i], p)
        p = p + 1
      end
      if obj.str == "=" then
        obj.char = get(map_str[i], p)
        p = p + 1
      end
      if obj.str == "#" then
        obj.char = get(map_str[i], p)
        p = p + 1
      end
      if obj.str == "~" then
        obj.num = tonumber(get(map_str[i], p), 20)
        p = p + 1
      end
      if tonumber(obj.str) ~= nil then
        obj.num = tonumber(obj.str)
        obj.str = "~"
      end
      if obj.str == "$" then
        obj.sprite = get(map_str[i], p)
        p = p + 1
      end
      table.insert(map[currentPanel][j], obj)
    end
  end
  gamestate = "ready"
  --love.mouse.setCursor()
end
