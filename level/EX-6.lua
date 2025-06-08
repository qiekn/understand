-- solve the mirrored board

newlevel = {}

newlevel.level_str = {
  { "S.T", "...", "C.U" },
  { "C..U", "..T.", ".U..", "T..S" },
  { "..S..", ".....", "TUTUT", ".....", "..C.." },
  { ".C..", "...U", "T...", "..S." },
  { "..T..", "..U..", "S.T.C", "..U..", "..T.." },
  { "C..S", "....", "UTUT", "...." },
  { "U.C", "...", "T.S" },
}
newlevel.correct_num = 4

function newlevel.SpecialDraw()
  love.graphics.setColor(frontcolor[1], frontcolor[2], frontcolor[3], 0.5)
  love.graphics.setLineWidth(linewidth * 1.5)
  if len(visit[panel_cnt + 1 - currentPanel]) > 0 then
    x0, y0 = toScreen(
      mapW[currentPanel] + 1 - visit[panel_cnt + 1 - currentPanel][1].x,
      visit[panel_cnt + 1 - currentPanel][1].y
    )
    drawSquare(x0, y0, boxwidth * 0.8)
    if len(visit[panel_cnt + 1 - currentPanel]) >= 2 then
      x1, y1 = toScreen(
        mapW[currentPanel] + 1 - visit[panel_cnt + 1 - currentPanel][2].x,
        visit[panel_cnt + 1 - currentPanel][2].y
      )
      pt = { x0 + (x1 - x0) * 0.4, y0 + (y1 - y0) * 0.4, x1, y1 }
      for i = 3, len(visit[panel_cnt + 1 - currentPanel]) do
        x1, y1 = toScreen(
          mapW[currentPanel] + 1 - visit[panel_cnt + 1 - currentPanel][i].x,
          visit[panel_cnt + 1 - currentPanel][i].y
        )
        table.insert(pt, x1)
        table.insert(pt, y1)
      end
      --rPrint(pt)
      if len(pt) >= 4 then
        love.graphics.line(pt)
      end
    end
  end
end

function newlevel.checkVictory()
  currentPanel0 = currentPanel
  currentPanel = panel_cnt + 1 - currentPanel
  local function isEnd(str)
    pos = getlast(visit[currentPanel0])
    --print(mapW[currentPanel]+1-pos.x,pos.y,str)
    return match(mapW[currentPanel] + 1 - pos.x, pos.y, str)
  end

  local function isStart(str)
    pos = visit[currentPanel0][1]
    --print(mapW[currentPanel]+1-pos.x,pos.y,str)
    return match(mapW[currentPanel] + 1 - pos.x, pos.y, str)
  end

  local function isCover(str)
    for i = 1, mapW[currentPanel] do
      for j = 1, mapH[currentPanel] do
        if match(mapW[currentPanel] + 1 - i, j, str) and not visit_grid[currentPanel0][i][j] then
          return false
        end
      end
    end
    return true
  end

  local function isBlock(str)
    for i = 1, mapW[currentPanel] do
      for j = 1, mapH[currentPanel] do
        if match(mapW[currentPanel] + 1 - i, j, str) and visit_grid[currentPanel0][i][j] then
          return false
        end
      end
    end
    return true
  end

  correct[currentPanel0][1] = isStart("C")
  correct[currentPanel0][2] = isEnd("S")
  correct[currentPanel0][3] = isCover("T")
  correct[currentPanel0][4] = isBlock("U")
  currentPanel = currentPanel0
end

newlevel.hint = {
  { x = 1, y = 1 },
  { x = 1, y = 2 },
  { x = 3, y = 2 },
  { x = 3, y = 3 },
  { x = 1, y = 3 },
}

newlevel.text = "Hint 1: Solve board 4 first.\nHint 2: The width of each board is: 3, 4, 5, 4, 5, 4, 3."

return newlevel
