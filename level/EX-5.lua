-- recursive

newlevel = {}

newlevel.level_str = {
  { "..C..", ".....", "C.1.C", ".....", "..C.." },
  { "2.C..", ".....", "C...C", ".....", "..C.." },
  { "..C..", ".3...", "C...C", "...3.", "..C.." },
  { "..C..", "...3.", "C...C", ".1...", "..C.." },
  { "..C..", ".1.5.", "C...C", ".5.3.", "..C.." },
  { "..C..", "..8..", "C8.9C", "..9..", "..C.." },
  { "..C..", "..8..", "C8.9C", "..9..", "..C.." },
  { "..C..", "..6.", "C7.6C", "..7..", "..C.." },
  { "..C..", "..6..", "C7.6C", "..7..", "..C.." },
}
newlevel.correct_num = 4

local function toScreen2(x, y)
  return boxX + (x - 3) * boxwidth / 6, boxY + (y - 3) * boxwidth / 6
end

function newlevel.SpecialDraw()
  for i = 1, mapW[currentPanel] do
    for j = 1, mapH[currentPanel] do
      love.graphics.setColor(1, 1, 1)
      boxX = mapleft + i * boxwidth
      boxY = maptop + j * boxwidth
      local l = linewidth / 4
      if l < 1 then
        l = 1
      end
      love.graphics.setLineWidth(l)
      local ch = get(map[currentPanel][i][j].str, 1)
      if ch == "~" then
        if len(visit[map[currentPanel][i][j].num]) > 0 then
          x0, y0 = toScreen2(visit[map[currentPanel][i][j].num][1].x, visit[map[currentPanel][i][j].num][1].y)
          drawSquare(x0, y0, boxwidth / 6 * 0.8)
          --print(len(visit[map[currentPanel][i][j].num]))
          if len(visit[map[currentPanel][i][j].num]) >= 2 then
            x1, y1 = toScreen2(visit[map[currentPanel][i][j].num][2].x, visit[map[currentPanel][i][j].num][2].y)
            pt = { x0 + (x1 - x0) * 0.4, y0 + (y1 - y0) * 0.4, x1, y1 }
            for k = 3, len(visit[map[currentPanel][i][j].num]) do
              x1, y1 = toScreen2(visit[map[currentPanel][i][j].num][k].x, visit[map[currentPanel][i][j].num][k].y)
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
    end
  end
end

function newlevel.checkVictory()
  panel_in = {}
  panel_out = {}
  for i = 1, panel_cnt do
    if len(visit[i]) == 0 then
      panel_in[i] = "none"
      panel_out[i] = "none"
    else
      if map[i][visit[i][1].x][visit[i][1].y].str == "C" then
        if visit[i][1].x == 1 then
          panel_in[i] = "left"
        elseif visit[i][1].x == mapW[i] then
          panel_in[i] = "right"
        elseif visit[i][1].y == 1 then
          panel_in[i] = "up"
        else
          panel_in[i] = "down"
        end
      else
        panel_in[i] = "none"
      end
      local n = len(visit[i])
      if map[i][visit[i][n].x][visit[i][n].y].str == "C" then
        if visit[i][n].x == 1 then
          panel_out[i] = "left"
        elseif visit[i][n].x == mapW[i] then
          panel_out[i] = "right"
        elseif visit[i][n].y == 1 then
          panel_out[i] = "up"
        else
          panel_out[i] = "down"
        end
      else
        panel_out[i] = "none"
      end
    end
  end
  currentPanel0 = currentPanel
  for i = 1, panel_cnt do
    currentPanel = i
    if len(visit[i]) ~= 0 then
      GetDirection()
      correct[currentPanel][1] = isStart("C")
      correct[currentPanel][2] = isEnd("C")
      correct[currentPanel][3] = isCover("~")
      local ans = true
      for j = 1, len(visit[currentPanel]) do
        if map[currentPanel][visit[currentPanel][j].x][visit[currentPanel][j].y].str == "~" then
          if j == 1 or j == len(visit[currentPanel]) then
            ans = false
          else
            if panel_in[map[currentPanel][visit[currentPanel][j].x][visit[currentPanel][j].y].num] == "none" then
              ans = false
            elseif
              panel_in[map[currentPanel][visit[currentPanel][j].x][visit[currentPanel][j].y].num] == "left"
              and direction[j - 1] ~= "R"
            then
              ans = false
            elseif
              panel_in[map[currentPanel][visit[currentPanel][j].x][visit[currentPanel][j].y].num] == "right"
              and direction[j - 1] ~= "L"
            then
              ans = false
            elseif
              panel_in[map[currentPanel][visit[currentPanel][j].x][visit[currentPanel][j].y].num] == "down"
              and direction[j - 1] ~= "U"
            then
              ans = false
            elseif
              panel_in[map[currentPanel][visit[currentPanel][j].x][visit[currentPanel][j].y].num] == "up"
              and direction[j - 1] ~= "D"
            then
              ans = false
            end
            if panel_out[map[currentPanel][visit[currentPanel][j].x][visit[currentPanel][j].y].num] == "none" then
              ans = false
            elseif
              panel_out[map[currentPanel][visit[currentPanel][j].x][visit[currentPanel][j].y].num] == "left"
              and direction[j] ~= "L"
            then
              ans = false
            elseif
              panel_out[map[currentPanel][visit[currentPanel][j].x][visit[currentPanel][j].y].num] == "right"
              and direction[j] ~= "R"
            then
              ans = false
            elseif
              panel_out[map[currentPanel][visit[currentPanel][j].x][visit[currentPanel][j].y].num] == "down"
              and direction[j] ~= "D"
            then
              ans = false
            elseif
              panel_out[map[currentPanel][visit[currentPanel][j].x][visit[currentPanel][j].y].num] == "up"
              and direction[j] ~= "U"
            then
              ans = false
            end
          end
        end
      end
      correct[currentPanel][4] = ans
    end
  end
  currentPanel = currentPanel0
end

newlevel.hint = {
  { x = 3, y = 1 },
  { x = 3, y = 3 },
  { x = 5, y = 3 },
}

newlevel.text = "Hint 1: Some boards look the same. It is intended.\nHint 2: This level is recursive."

return newlevel
