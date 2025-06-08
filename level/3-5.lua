newlevel = {}

--Area Contains One Square

newlevel.level_str = {
  { "C C", " S " },
  { "C    ", " S S ", "    C" },
  { "     ", "  S  ", " CCC ", "  S  ", "     " },
  { "C   ", "  S ", " S  ", "   C" },
  { "S   S", "C   C", "S   S" },
  { "   ", "C C", "   " },
  { "C...C", ".S...", "..S..", "...S.", "C...C" },
  { "       ", "CSCCCSC", "CCSCSCC", "       " },
}

newlevel.correct_num = 4

newlevel.hint = {
  { x = 1, y = 1 },
  { x = 3, y = 1 },
}

newlevel.text = "Board 6 is telling something."

function newlevel.checkVictory()
  FloodFill()
  correct[currentPanel][1] = isStart("C")
  correct[currentPanel][2] = isEnd("C")
  correct[currentPanel][3] = isBlock("S")
  local ans = true
  for i = 1, len(FloodFillShapeCount[currentPanel]) do
    for k, v in pairs(FloodFillShapeCount[currentPanel][i]) do
      if k == "S" and v > 1 then
        ans = false
      end
    end
  end
  correct[currentPanel][4] = ans
end
return newlevel
