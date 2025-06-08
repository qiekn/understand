-- area is reverse, with shape

newlevel = {}

newlevel.level_str = {
  { "C C", "   " },
  { "S  ", " S " },
  { "C   ", "    ", "  C ", "    " },
  { "C  C", "    ", "    ", "S  S" },
  { "S....", ".S...", ".....", "...C.", "....C" },
  { "S  C", "    ", "    ", "C  S" },
  { "S   C", "     ", "  U  ", "     ", "S   C" },
  { ".......", ".C.S.U.", ".......", ".C.S.U.", ".......", "......." },
  { "C...S.....", "..........", "....C.....", "........S.", ".........." },
  {
    "........",
    "........",
    "...C....",
    ".....C..",
    "..S.....",
    "....S...",
    ".U......",
    "........",
  },
}

newlevel.correct_num = 3

function newlevel.checkVictory()
  correct[currentPanel][1] = isBlock("all")
  FloodFill()
  local ans1 = true
  local ans2 = true
  for i = 1, len(FloodFillRes[currentPanel]) do
    for k, v in pairs(FloodFillShapeCount[currentPanel][i]) do
      for j = i + 1, len(FloodFillRes[currentPanel]) do
        for k2, v2 in pairs(FloodFillShapeCount[currentPanel][j]) do
          if k == k2 and k ~= " " and k2 ~= " " then
            print(k, k2)
            ans1 = false
          end
        end
      end
    end
    maxX, minX, maxY, minY = AreaMaxMin(FloodFillRes[currentPanel][i])
    local ans = AreaMirrorWithShape(
      FloodFillRes[currentPanel][i],
      FloodFillRes[currentPanel][i],
      maxX + minX,
      maxY + minY,
      "reverse"
    )
    ans2 = ans and ans2
  end
  correct[currentPanel][2] = ans1
  correct[currentPanel][3] = ans2
end

newlevel.hint = {
  { x = 1, y = 2 },
  { x = 3, y = 2 },
}
return newlevel
