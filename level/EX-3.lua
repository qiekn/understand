-- soko

newlevel = {}

newlevel.level_str = {
  { "O O", "CS ", "O O" },
  { "O   O", "     ", " C S ", "     ", "O   O" },
  { "   C", "    ", "TTTT", "    ", "S   " },
  {
    "C       ",
    "        ",
    "  U  D  ",
    "        ",
    "        ",
    "  D  U  ",
    "        ",
    "       S",
  },
  { "       ", "       ", "  O O  ", "C T T  ", "  U U  ", "       ", "   S   " },
  { "     ", "     ", " C S ", "     ", "     " },
  {
    "C        ",
    "         ",
    "         ",
    "   OOO   ",
    "   O O   ",
    "   OOO   ",
    "         ",
    "         ",
    "        S",
  },
}
newlevel.correct_num = 5

newlevel.text = "The rules are checked when you finish the line."

panel_history = {}
function newlevel.ResetPanel()
  LoadPanel()
  panel_history[currentPanel] = {}
  panel_history[currentPanel][1] = {}
  for i = 1, mapW[currentPanel] do
    panel_history[currentPanel][1][i] = {}
    for j = 1, mapH[currentPanel] do
      panel_history[currentPanel][1][i][j] = map[currentPanel][i][j].str
    end
  end
end

function newlevel.LoadLine()
  for i = 2, len(visit[currentPanel]) do
    TryPush(
      visit[currentPanel][i - 1].x,
      visit[currentPanel][i - 1].y,
      visit[currentPanel][i].x,
      visit[currentPanel][i].y
    )
  end
end

function TryPush(x1, y1, x2, y2)
  if map[currentPanel][x2][y2].str == " " then
    return true
  end
  local x3 = x2 + x2 - x1
  local y3 = y2 + y2 - y1
  if x3 == 0 or y3 == 0 or x3 > mapW[currentPanel] or y3 > mapH[currentPanel] then
    return false
  end
  if TryPush(x2, y2, x3, y3) then
    map[currentPanel][x3][y3].str = map[currentPanel][x2][y2].str
    map[currentPanel][x2][y2].str = " "
    return true
  else
    return false
  end
end

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
  if (xx > 0) and (yy > 0) and (xx <= mapWidth) and (yy <= mapHeight) then
    if dis(xx, yy, lastpos.x, lastpos.y) == 1 then
      if not visit_grid[currentPanel][xx][yy] then
        visit_grid[currentPanel][xx][yy] = true
        table.insert(visit[currentPanel], { x = xx, y = yy })
        TryPush(lastpos.x, lastpos.y, xx, yy)
        panel_history[currentPanel][len(visit[currentPanel])] = {}
        for i = 1, mapW[currentPanel] do
          panel_history[currentPanel][len(visit[currentPanel])][i] = {}
          for j = 1, mapH[currentPanel] do
            panel_history[currentPanel][len(visit[currentPanel])][i][j] = map[currentPanel][i][j].str
          end
        end
      else
        if
          (visit[currentPanel][len(visit[currentPanel]) - 1].x == xx)
          and (visit[currentPanel][len(visit[currentPanel]) - 1].y == yy)
        then
          visit_grid[currentPanel][lastpos.x][lastpos.y] = false
          table.remove(visit[currentPanel])
          for i = 1, mapW[currentPanel] do
            for j = 1, mapH[currentPanel] do
              map[currentPanel][i][j].str = panel_history[currentPanel][len(visit[currentPanel])][i][j]
            end
          end
        end
      end
    end
  end
end

function newlevel.checkVictory()
  for i = 1, mapW[currentPanel] do
    for j = 1, mapH[currentPanel] do
      map[currentPanel][i][j].str = panel_history[currentPanel][1][i][j]
    end
  end
  for i = 2, len(visit[currentPanel]) do
    TryPush(
      visit[currentPanel][i - 1].x,
      visit[currentPanel][i - 1].y,
      visit[currentPanel][i].x,
      visit[currentPanel][i].y
    )
  end
  FloodFill()
  correct[currentPanel][1] = isStart("C")
  correct[currentPanel][2] = isEnd("S")
  local ans1 = true
  for i = 2, len(visit[currentPanel]) - 1 do
    if map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str ~= " " then
      ans1 = false
    end
  end
  correct[currentPanel][3] = ans1
  local ans = true
  local ans2 = true
  for i = 1, len(FloodFillShapeCount[currentPanel]) do
    local tot = 0
    for k, v in pairs(FloodFillShapeCount[currentPanel][i]) do
      if k ~= " " then
        if tot > 0 then
          ans = false
        end
        tot = tot + v
      end
    end
    if tot ~= 2 then
      ans2 = false
    end
  end
  correct[currentPanel][4] = ans
  correct[currentPanel][5] = ans2
end
newlevel.hint = {
  { x = 1, y = 2 },
  { x = 3, y = 2 },
}
return newlevel
