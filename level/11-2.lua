-- empty is start and end

newlevel = {}

newlevel.level_str = {
  { "   ", "   ", "   " },
  { "   ", "C S", "   " },
  { " C ", "S S", " C " },
  { "C...C", ".....", "S.C.S", ".....", "C...C" },
  { "C...C", ".SCS.", "C...C" },
}

newlevel.correct_num = 4

function newlevel.checkVictory()
  correct[currentPanel][1] = isStart(" ")
  correct[currentPanel][2] = isEnd(" ")
  correct[currentPanel][3] = isCover("C")
  correct[currentPanel][4] = isBlock("S")
end

newlevel.hint = {
  { x = 1, y = 2 },
  { x = 3, y = 2 },
}
return newlevel
