--each area is same shape

newlevel = {}

newlevel.level_str = {
  { "C S", "   ", "C S" },
  { "C C", "   ", "S S" },
  { "CS   ", "   CS" },
  { "C   S", "     ", " C S " },
  { "C   C", "     ", " S S " },
  { "C  C", "    ", "S  S" },
  { "CS...", ".....", "....C", ".....", "....S" },
  { "......", "......", ".C...C", "......", ".S.S..", "......", "......" },
  { "......C....", "...........", "....S.C....", "...........", "....S......" },
}

newlevel.correct_num = 3

newlevel.hint = {
  { x = 1, y = 2 },
  { x = 3, y = 2 },
}

function newlevel.checkVictory()
  FloodFill()
  local ans = true
  local ans2 = true
  for i = 1, len(FloodFillRes[currentPanel]) do
    if i > 1 then
      maxX, minX, maxY, minY = AreaMaxMin(FloodFillRes[currentPanel][1])
      maxX2, minX2, maxY2, minY2 = AreaMaxMin(FloodFillRes[currentPanel][i])
      if
        not AreaMirror(FloodFillRes[currentPanel][1], FloodFillRes[currentPanel][i], maxX - maxX2, maxY - maxY2, "same")
      then
        ans = false
      end
    end
    if FloodFillShapeCount[currentPanel][i]["C"] ~= 1 or FloodFillShapeCount[currentPanel][i]["S"] ~= 1 then
      ans2 = false
    end
  end
  correct[currentPanel][1] = isBlock("CS")
  correct[currentPanel][2] = ans2
  correct[currentPanel][3] = ans
end
return newlevel
