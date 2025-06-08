-- reverse

newlevel = {}

newlevel.level_str = {
  { "C  ", "U S" },
  { " UC", "   ", "S  " },
  { "C U  ", "     ", "U    ", "     ", "    S" },
  { "CS", "  " },
  { " C ", "S  ", "   " },
  { "C U  ", "  U  ", "    S", "     ", "     " },
  { "......", "......", "...UUS", "U.....", "C.....", "...U..", ".U...." },
  { " CS ", "    ", " U  ", "    " },
  { " C S ", "   U ", "     ", "     ", "     " },
}

newlevel.correct_num = 4

function newlevel.checkVictory()
  correct[currentPanel][1] = isStart("C")
  correct[currentPanel][2] = isEnd("S")
  correct[currentPanel][3] = isBlock("U")
  maxX, minX, maxY, minY = AreaMaxMin(visit[currentPanel])
  correct[currentPanel][4] =
    AreaMirror(visit[currentPanel], visit[currentPanel], mapW[currentPanel] + 1, mapH[currentPanel] + 1, "reverse")
end

newlevel.hint = {
  { x = 1, y = 1 },
  { x = 2, y = 1 },
  { x = 2, y = 2 },
  { x = 3, y = 2 },
}
return newlevel
