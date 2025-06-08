--area is divide by num

newlevel = {}

newlevel.level_str = {
  { "     ", "     ", "  2  ", "     ", "     " },
  { "     ", "     ", "  3  ", "     ", "     " },
  { "     ", "     ", "  4  ", "     ", "     " },
  { "     ", "     ", "  6  ", "     ", "     " },
  { "   ", "2 2", "   " },
  { "2   ", "    ", "   2" },
  { "3   ", "    ", "   3" },
  { "4   ", "    ", "   4" },
  { "....", ".2..", "..4.", "...." },
  { "....", ".2..", "..3.", "...." },
  { "......", "......", "..3...", "...4..", "......", "......" },
  { "......", "......", "..4...", "...5..", "......", "......" },
  { "......", "......", "..3...", "...5..", "......", "......" },
  { "......", "......", "..4...", "...7..", "......", "......" },
}

newlevel.correct_num = 3

newlevel.hint = {
  { x = 2, y = 2 },
  { x = 2, y = 3 },
  { x = 3, y = 3 },
  { x = 3, y = 4 },
}
newlevel.CircleColor = { 1, { 4, 5 }, 4 }

function newlevel.checkVictory()
  correct[currentPanel][1] = isCover("all")
  FloodFill()
  local ans = true
  local ans2 = (IsRectangle(visit[currentPanel]) == -1)
  for i = 1, mapW[currentPanel] do
    for j = 1, mapH[currentPanel] do
      if map[currentPanel][i][j].str == "~" then
        ans = ans and len(visit[currentPanel]) % map[currentPanel][i][j].num == 0
      end
    end
  end
  for i = 1, mapW[currentPanel] do
    for j = 1, mapH[currentPanel] do
      if map[currentPanel][i][j].str == "~" then
        if ans then
          ans = ans and cut_solve(visit[currentPanel], map[currentPanel][i][j].num, true)
        end
      end
    end
  end
  correct[currentPanel][2] = ans
  correct[currentPanel][3] = ans2
end
return newlevel
