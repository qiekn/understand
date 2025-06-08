newlevel = {}

--Area Contains No Duplicate

newlevel.level_str = {
  { "U U" },
  { "U  ", "   ", "  U" },
  { "     ", " C S ", "     ", " C S ", "     " },
  { "     ", "C U S", "     ", "C U S", "     " },
  { "     ", "C C C", "     ", "S S S", "     " },
  { "C  C", "   S", "    ", "C SC" },
  { "C  U", "    ", "C  U", "    ", "S  S" },
}

newlevel.correct_num = 2
newlevel.hint = {
  { x = 2, y = 1 },
}
function newlevel.checkVictory()
  FloodFill()
  correct[currentPanel][1] = isBlock("all")
  local ans = true
  for i = 1, len(FloodFillShapeCount[currentPanel]) do
    for k, v in pairs(FloodFillShapeCount[currentPanel][i]) do
      if k ~= " " and v > 1 then
        ans = false
      end
    end
  end
  correct[currentPanel][2] = ans
end

newlevel.text = "Seperate something else."
return newlevel
