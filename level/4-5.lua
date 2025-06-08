--each area is same shape after rotation

newlevel = {}

newlevel.level_str = {
  { "T  T", "    " },
  { "T   T", "     ", "     " },
  { "   T", "    ", "    ", "T   " },
  { ".S..S.", "T....T" },
  { "T   T", "     ", "S   S" },
  { "...T", "....", ".S..", "....", "T..." },
  { "T......T", "........", "........", "........", "T......T" },
  { ".......", ".......", "..T.T.T", ".......", "......." },
}

newlevel.correct_num = 4

newlevel.hint = {
  { x = 2, y = 1 },
  { x = 2, y = 2 },
  { x = 4, y = 2 },
}

function newlevel.checkVictory()
  FloodFill()
  local ans = true
  local ans2 = true
  local ans3 = true
  for i = 1, len(FloodFillRes[currentPanel]) - 1 do
    for j = i + 1, len(FloodFillRes[currentPanel]) do
      maxX, minX, maxY, minY = AreaMaxMin(FloodFillRes[currentPanel][i])
      maxX2, minX2, maxY2, minY2 = AreaMaxMin(FloodFillRes[currentPanel][j])
      if
        AreaMirror(FloodFillRes[currentPanel][i], FloodFillRes[currentPanel][j], maxX - maxX2, maxY - maxY2, "same")
      then
        ans3 = false
      end
      if
        not (
          AreaMirror(FloodFillRes[currentPanel][i], FloodFillRes[currentPanel][j], maxX - maxX2, maxY - maxY2, "same")
          or AreaMirror(
            FloodFillRes[currentPanel][i],
            FloodFillRes[currentPanel][j],
            minX - minY2,
            maxY + minX2,
            "clockwise"
          )
          or AreaMirror(
            FloodFillRes[currentPanel][i],
            FloodFillRes[currentPanel][j],
            maxX + minY2,
            minY - minX2,
            "anticlockwise"
          )
          or AreaMirror(
            FloodFillRes[currentPanel][i],
            FloodFillRes[currentPanel][j],
            maxX + minX2,
            maxY + minY2,
            "reverse"
          )
        )
      then
        ans = false
      end
    end
  end
  for i = 1, len(FloodFillRes[currentPanel]) do
    ans2 = ans2 and FloodFillShapeCount[currentPanel][i]["T"] == 1
  end
  correct[currentPanel][1] = isBlock("all")
  correct[currentPanel][2] = ans2
  correct[currentPanel][3] = ans
  correct[currentPanel][4] = ans3
end
return newlevel
