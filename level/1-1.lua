-- circle is start, square is end

newlevel = {}

newlevel.level_str = {
  { "C S" },
  { "S C" },
  { "C ", " S" },
  { "S  U", "    ", "    ", "T  C" },
}

newlevel.correct_num = 2

newlevel.text = "Each circle below the panel represents a rule.\nFullfill all of them to win."

newlevel.time = -10

newlevel.hint = {
  { x = 1, y = 1 },
  { x = 3, y = 1 },
}
function newlevel.checkVictory()
  correct[currentPanel][1] = isStart("C")
  correct[currentPanel][2] = isEnd("S")
end

return newlevel
