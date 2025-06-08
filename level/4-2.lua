--each area is 1*x

newlevel = {}

newlevel.level_str = {
  { " US", "C  " },
  { "CU S", "    " },
  { "CCC", "CUS", "SSS" },
  { "   S", " U  ", "C   " },
  { "  CS", " U  ", "    " },
  { "....", ".C..", "....", "...S" },
  { ".....", "..C..", ".....", "..S..", "....." },
  { ".....", ".SU..", ".UC..", ".....", "....." },
  { "......", "......", "..UCU.", "..SU..", "......", "......" },
}

newlevel.correct_num = 4

newlevel.hint = {
  { x = 1, y = 2 },
  { x = 3, y = 2 },
  { x = 3, y = 1 },
}

function newlevel.checkVictory()
  FloodFill()
  local ans = true
  for i = 1, len(FloodFillRes[currentPanel]) do
    x, y = IsRectangle(FloodFillRes[currentPanel][i])
    if not ((x == 1 and y > 1) or (x > 1 and y == 1)) then
      ans = false
    end
  end
  correct[currentPanel][1] = isStart("C")
  correct[currentPanel][2] = isEnd("S")
  correct[currentPanel][3] = isBlock("U")
  correct[currentPanel][4] = ans
end
return newlevel
