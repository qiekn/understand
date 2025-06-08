--area can be divided into 2

newlevel = {}

newlevel.level_str = {
  { "S C", " S " },
  { "S C", "   ", "S C" },
  { "....", ".SS.", "....", "C..." },
  { "..S", "S.C", "..." },
  { "...S", "....", "S..C" },
  { "S...S", "..S..", "..C.S" },
  { "S...S", ".C.C.", "....." },
  { "..S.", ".SC.", "S..." },
  { "..S.", ".S..", "SC.." },
  { "...S", ".C..", "....", "S..." },
}

newlevel.correct_num = 4

newlevel.hint = {
  { x = 3, y = 1 },
  { x = 3, y = 2 },
}

function newlevel.checkVictory()
  FloodFill()
  local ans = 0
  local ans2 = true
  shapes = {}
  for i = 1, len(FloodFillRes[currentPanel]) do
    if FloodFillShapeCount[currentPanel][i]["S"] ~= nil then
      ans = ans + 1
      ans2 = ans2 and cut_solve(FloodFillRes[currentPanel][i], 2, true)
    end
  end
  correct[currentPanel][1] = isCover("C")
  correct[currentPanel][2] = isBlock("S")
  correct[currentPanel][3] = (ans == 1)
  correct[currentPanel][4] = ans2
end
return newlevel
