-- value is paired

newlevel = {}

newlevel.level_str = {
  { "1 1", "   ", "2 2" },
  { "112", "332" },
  { ".....", ".1.2.", ".....", ".2.1.", "....." },
  {
    ".......4",
    "......3.",
    ".....2..",
    "....1...",
    "...1....",
    "..2.....",
    ".3......",
    "4.......",
  },
  {
    ".......3",
    "......2.",
    ".....4..",
    "....1...",
    "...1....",
    "..4.....",
    ".2......",
    "3.......",
  },
  { "      ", " 2  1 ", " 3  2 ", " 1  3 ", "      " },
  { "      ", " 3  1 ", " 2  2 ", " 1  3 ", "      " },
  --  {"      ",
  --   " 1  3 ",
  --   " 2  4 ",
  --   " 3  1 ",
  --   " 4  2 ",
  --   "      "},
}

newlevel.correct_num = 2

newlevel.hint = {
  { x = 1, y = 1 },
  { x = 3, y = 1 },
  { x = 3, y = 3 },
  { x = 1, y = 3 },
}
function newlevel.checkVictory()
  correct[currentPanel][1] = isCover("~")
  correct[currentPanel][2] = true
  local lastn = 0
  for i = 1, len(visit[currentPanel]) do
    if map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str == "~" then
      if map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].num < lastn then
        correct[currentPanel][2] = false
      end
      lastn = map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].num
    end
  end
end
return newlevel
