-- horizontal mirror

newlevel = {}

newlevel.level_str = {
  { "CUS", "   " },
  { "CU S", "    " },
  { "C..US", ".U...", "....." },
  { "C U  S", "     U" },
  { "    U    ", "CU   U  S", "        U" },
  { "..CS..", "...U..", "..U...", "....U.", ".U....", ".....U" },
  { "....U......", ".U.....U...", "C...U....US", "U....U.....", ".......U..." },
}

newlevel.hint = {
  { x = 1, y = 1 },
  { x = 1, y = 2 },
  { x = 3, y = 2 },
  { x = 3, y = 1 },
}

newlevel.correct_num = 4

function newlevel.checkVictory()
  correct[currentPanel][1] = isStart("C")
  correct[currentPanel][2] = isEnd("S")
  correct[currentPanel][3] = isBlock("U")
  maxX, minX, maxY, minY = AreaMaxMin(visit[currentPanel])
  correct[currentPanel][4] =
    AreaMirror(visit[currentPanel], visit[currentPanel], mapW[currentPanel] + 1, 0, "horizontal")
end
return newlevel
