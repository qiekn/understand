--two areas add up to another

newlevel = {}

newlevel.level_str = {
  { "S S", "  S", "   ", "S  " },
  { "S  SS", "     ", "SSS  " },
  { "   SS", "     ", "SS   ", "SS SS" },
  { "SS S", "    ", "S   ", " S  " },
  { "    ", "    ", "SSS ", "    ", "SSSS" },
  { "   ", "   ", "S  ", "S S" },
  { "     ", "     ", "     ", "     ", "SSSSS" },
  { "     ", "    S", "S    ", "SSS  " },
  { "     S", "  S   ", "    S ", " S    " },
}

newlevel.correct_num = 3

newlevel.hint = {
  { x = 2, y = 1 },
  { x = 2, y = 2 },
  { x = 1, y = 2 },
  { x = 1, y = 3 },
  { x = 3, y = 3 },
  { x = 3, y = 4 },
  { x = 2, y = 4 },
}

function newlevel.checkVictory()
  FloodFill()
  local ans = false
  local maxi = 1
  for i = 1, len(FloodFillRes[currentPanel]) do
    if len(FloodFillRes[currentPanel][i]) > len(FloodFillRes[currentPanel][maxi]) then
      maxi = i
    end
  end
  shapes = {}
  for i = 1, len(FloodFillRes[currentPanel]) do
    if i ~= maxi then
      table.insert(shapes, FloodFillRes[currentPanel][i])
    end
  end
  correct[currentPanel][1] = isBlock("all")
  correct[currentPanel][2] = len(FloodFillRes[currentPanel]) == 3
  correct[currentPanel][3] = tetris_solve(FloodFillRes[currentPanel][maxi], shapes, false)
end
return newlevel
