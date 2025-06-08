--length is prime

newlevel = {}

newlevel.level_str = {
  { "CCU", "   " },
  { "CUC", "   " },
  { "C  C", "UUU ", "  U ", "  UC" },
  { "C     C", "       " },
  { "    ", " CC ", " C  ", "    " },
  { "C       C", "         " },
  { "C..........", "...........", "UUUUUUUUUU.", "...........", "C.........." },
  { "C  C    ", "UUUUUUU ", "     C  ", " UUUUUUU", "  C    C" },
}

newlevel.correct_num = 4

newlevel.text = "The last rule cares about length."

function newlevel.checkVictory()
  correct[currentPanel][1] = isStart("C")
  correct[currentPanel][2] = isEnd("C")
  correct[currentPanel][3] = isBlock("U")
  correct[currentPanel][4] = isPrime(len(visit[currentPanel]))
end

newlevel.hint = {
  { x = 1, y = 1 },
  { x = 2, y = 1 },
}
return newlevel
