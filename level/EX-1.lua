-- circle is start, square is end, star is cover, triangle is block

newlevel = {}

newlevel.level_str = {
  { "       ", "       ", "   T   ", "  CUS  ", "   T   ", "       ", "       " },
  { "       ", "       ", "  U U  ", " CTTTS ", "  U U  ", "       ", "       " },
  { "  U U  ", "  U U  ", "  U U  ", " CTTTS ", "  U U  ", "  U U  ", "  U U  " },
  --{"CUS"},
  --{"CUS"},
  { "       ", "       ", "       ", "  CUS  ", "       ", "       ", "       " },
}
newlevel.correct_num = 4

function newlevel.checkVictory()
  correct[currentPanel][1] = isStart("C")
  local last = getlast(visit[currentPanel])
  if (last.x > 0) and (last.y > 0) and (last.x <= mapWidth) and (last.y <= mapHeight) then
    correct[currentPanel][2] = isEnd("S")
  else
    correct[currentPanel][2] = false
  end
  CountShape()
  screenWidth = love.graphics.getWidth()
  screenHeight = love.graphics.getHeight()

  correct[currentPanel][3] = shape_cover_cnt["T"] == 1
  if currentPanel == 4 then
    print("hello")
    mapWidth = mapW[currentPanel]
    mapHeight = mapH[currentPanel]

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
    correct[currentPanel][3] = false

    for i = 2, len(visit[currentPanel]) do
      uiSize = math.min(screenWidth / 15, screenHeight / 9)
      local x0, y0 = toScreen(visit[currentPanel][i].x, visit[currentPanel][i].y)
      local x1, y1 = toScreen(visit[currentPanel][i - 1].x, visit[currentPanel][i - 1].y)
      print(
        visit[currentPanel][i - 1].x,
        visit[currentPanel][i - 1].y,
        visit[currentPanel][i].x,
        visit[currentPanel][i].y
      )
      print(screenWidth - uiSize * 1.2, screenWidth - uiSize * 0.2, x0)
      if visit[currentPanel][i].y == 4 and x0 >= screenWidth - uiSize * 1.2 and x0 <= screenWidth - uiSize * 0.2 then
        correct[currentPanel][3] = true
      end
      if
        visit[currentPanel][i].y == 4
        and visit[currentPanel][i - 1].y == 4
        and x0 >= screenWidth - uiSize * 0.7
        and x1 <= screenWidth - uiSize * 0.7
      then
        correct[currentPanel][3] = true
      end
      if
        visit[currentPanel][i].y == 4
        and visit[currentPanel][i - 1].y == 4
        and x0 <= screenWidth - uiSize * 0.7
        and x1 >= screenWidth - uiSize * 0.7
      then
        correct[currentPanel][3] = true
      end
    end
  end
  correct[currentPanel][4] = isBlock("U")
end
newlevel.hint = {
  { x = 3, y = 4 },
  { x = 3, y = 3 },
  { x = 5, y = 3 },
  { x = 5, y = 4 },
}
function newlevel.SpecialDraw() end
function newlevel.mouseDraw()
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
  if dis(xx, yy, lastpos.x, lastpos.y) == 1 then
    if visit_grid[currentPanel][xx] == nil then
      visit_grid[currentPanel][xx] = {}
    end
    if visit_grid[currentPanel][xx][yy] ~= true then
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

newlevel.text = "Think outside the box."
return newlevel
