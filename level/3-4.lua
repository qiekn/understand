--Area Count is One

newlevel = {}

newlevel.level_str = {
  { "   ", "TUT", "   " },
  { "T  ", "   ", "U T" },
  { "..T..", ".U.U.", ".....", ".U.U.", "..T.." },
  { "U  T", " T  ", "  U ", "T   " },
  { "T   T", " U U ", "  T  ", " U U ", "T   T" },
  { "       ", "       ", "TUTUTUT", "       ", "       " },
}

newlevel.correct_num = 3

function newlevel.checkVictory()
  FloodFill()
  correct[currentPanel][1] = isCover("T")
  correct[currentPanel][2] = isBlock("U")
  correct[currentPanel][3] = (len(FloodFillRes[currentPanel]) == 1)
end

newlevel.hint = {
  { x = 1, y = 2 },
  { x = 1, y = 3 },
  { x = 3, y = 3 },
  { x = 3, y = 2 },
}

newlevel.text = "What breaks rule 3?"
return newlevel
