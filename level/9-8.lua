-- area is diag adjacent

newlevel = {}

newlevel.level_str = {
  { "S  ", " S ", "   " },
  { "S  ", "   ", " S ", "   " },
  { "S   ", "    ", "  S ", "    " },
  { "     ", "  S  ", "     ", "  S  ", "     " },
  { "     ", " S   ", "   S ", " S   ", "     " },
  { "......", ".S..S.", "......", "......", ".S..S.", "......" },
  { ".......", ".S...S.", ".......", "...S...", ".......", ".S...S.", "......." },
}

newlevel.correct_num = 3

newlevel.hint = {
  { x = 2, y = 1 },
  { x = 3, y = 1 },
  { x = 3, y = 3 },
  { x = 1, y = 3 },
  { x = 1, y = 2 },
}
function newlevel.checkVictory()
  local function AreaIsConnect(n)
    isConnect[n] = true
    for i = 1, len(FloodFillRes[currentPanel]) do
      if isConnect[i] == false then
        for xx = 1, mapW[currentPanel] do
          for yy = 1, mapH[currentPanel] do
            local cnt = 0
            local cnt2 = 0
            for k = 1, len(FloodFillRes[currentPanel][i]) do
              if
                (xx == FloodFillRes[currentPanel][i][k].x or xx == FloodFillRes[currentPanel][i][k].x - 1)
                and (yy == FloodFillRes[currentPanel][i][k].y or yy == FloodFillRes[currentPanel][i][k].y - 1)
              then
                cnt = cnt + 1
              end
            end
            for k = 1, len(FloodFillRes[currentPanel][n]) do
              if
                (xx == FloodFillRes[currentPanel][n][k].x or xx == FloodFillRes[currentPanel][n][k].x - 1)
                and (yy == FloodFillRes[currentPanel][n][k].y or yy == FloodFillRes[currentPanel][n][k].y - 1)
              then
                cnt2 = cnt2 + 1
              end
            end
            if (cnt == 1 or cnt == 3) and (cnt2 == 1 or cnt2 == 3) then
              AreaIsConnect(i)
            end
          end
        end
      end
    end
  end

  FloodFill()
  correct[currentPanel][1] = isBlock("all")
  local ans = true
  isConnect = {}
  for i = 1, len(FloodFillRes[currentPanel]) do
    if FloodFillShapeCount[currentPanel][i]["S"] ~= 1 then
      ans = false
    end
    isConnect[i] = false
  end
  isConnect[1] = true
  AreaIsConnect(1)
  local ans2 = true
  for i = 1, len(FloodFillRes[currentPanel]) do
    if not isConnect[i] then
      ans2 = false
    end
  end

  correct[currentPanel][2] = ans
  correct[currentPanel][3] = ans2
end
return newlevel
