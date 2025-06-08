newlevel = {}

--arrow is visit path

newlevel.level_str = {
  { "   ", " U ", "   " },
  { " D ", "   ", " D " },
  { " U ", "   ", " R " },
  { " L ", "   ", " D " },
  { "ULR", "   ", "   " },
  { "L D R", "     ", "     ", "U   U" },
  { " R D ", "     ", " R D ", "R   D" },
}

newlevel.correct_num = 2

newlevel.hint = {
  { x = 3, y = 2 },
  { x = 3, y = 1 },
}
function newlevel.checkVictory()
  correct[currentPanel][1] = isBlock("all")
  local U = 0
  local D = 0
  local L = 0
  local R = 0
  for i = 1, mapW[currentPanel] do
    for j = 1, mapH[currentPanel] do
      local ch = map[currentPanel][i][j].str
      if ch == "U" then
        U = U + 1
      elseif ch == "D" then
        D = D + 1
      elseif ch == "L" then
        L = L + 1
      elseif ch == "R" then
        R = R + 1
      end
    end
  end
  for i = 2, len(visit[currentPanel]) do
    local p1 = visit[currentPanel][i]
    local p2 = visit[currentPanel][i - 1]
    if p1.x == p2.x + 1 then
      R = R - 1
    elseif p1.x == p2.x - 1 then
      L = L - 1
    elseif p1.y == p2.y + 1 then
      D = D - 1
    elseif p1.y == p2.y - 1 then
      U = U - 1
    end
  end
  correct[currentPanel][2] = R == 0 and L == 0 and D == 0 and U == 0
end
return newlevel
