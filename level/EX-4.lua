-- all board has same solution
-- S is cover, U is pair, C is alone
newlevel = {}

newlevel.level_str = {
  { "...U..U", ".......", ".......", "S.....S", ".......", ".......", "U..U..." },
  { ".......", "C.C....", ".......", "..U.U..", ".......", "....S.S", "......." },
  { ".......", "..U....", "....U.U", ".......", ".U.....", ".......", "......." },
  { "...C...", ".......", "....C..", ".......", ".....C.", ".......", "......." },
  { ".......", ".S.S...", ".......", "..U.U..", ".......", "...C.C.", "......." },
}
newlevel.correct_num = 4

function newlevel.checkVictory()
  currentPanel0 = currentPanel
  for iii = 1, panel_cnt do
    currentPanel = iii
    if len(visit[currentPanel]) ~= 0 then
      if currentPanel ~= currentPanel0 then
        visit[currentPanel] = {}
        for i = 1, len(visit[currentPanel0]) do
          table.insert(visit[currentPanel], visit[currentPanel0][i])
        end
        for i = 1, mapW[currentPanel] do
          for j = 1, mapH[currentPanel] do
            visit_grid[currentPanel][i][j] = visit_grid[currentPanel0][i][j]
          end
        end
      end
      correct[currentPanel][1] = isCover("S")
      correct[currentPanel][2] = isBlock("CUT")
      FloodFill()
      local ans = 0
      local ans2 = true
      local ans3 = true
      for i = 1, len(FloodFillRes[currentPanel]) do
        if FloodFillShapeCount[currentPanel][i]["T"] ~= nil then
          ans = ans + 1
        end
        if FloodFillShapeCount[currentPanel][i]["U"] ~= 2 and FloodFillShapeCount[currentPanel][i]["U"] ~= nil then
          ans2 = false
        end
        if FloodFillShapeCount[currentPanel][i]["C"] ~= nil then
          if
            FloodFillShapeCount[currentPanel][i]["C"] ~= 1
            or FloodFillShapeCount[currentPanel][i]["U"] ~= nil
            or FloodFillShapeCount[currentPanel][i]["S"] ~= nil
            or FloodFillShapeCount[currentPanel][i]["T"] ~= nil
          then
            ans3 = false
          end
        end
      end
      --  correct[currentPanel][3]=ans<=1
      correct[currentPanel][3] = ans2
      correct[currentPanel][4] = ans3
      if level_lines[currentLevel] == nil then
        level_lines[currentLevel] = {}
      end
      level_lines[currentLevel][currentPanel] = {}
      for i = 1, len(visit[currentPanel]) do
        table.insert(
          level_lines[currentLevel][currentPanel],
          { x = visit[currentPanel][i].x, y = visit[currentPanel][i].y }
        )
      end
    end
  end

  currentPanel = currentPanel0
end

newlevel.hint = {
  { x = 1, y = 4 },
  { x = 7, y = 4 },
}

newlevel.text = "There's some relationship between the boards."

return newlevel
