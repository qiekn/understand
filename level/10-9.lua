newlevel = {}

--area has same in and out

newlevel.level_str = {
  { " L ", "   ", " R " },
  { "   ", "U D", "   " },
  { "    ", " U  ", "  L ", "    " },
  { "    ", " R  ", "  D ", "    " },
  { "    ", "U   ", "   D", "    " },
  { "...........", "...........", "U..L...R..U", "...........", "..........." },
  { "...........", "...........", "D..L...R..D", "...........", "..........." },
  { "...........", "...........", "U..L...R..D", "...........", "..........." },
  { ".........", ".........", ".........", "..U...U..", ".........", ".........", "........." },
  { ".......", ".......", "..R....", ".......", "..L.L..", ".......", "......." },
  {
    "...........",
    "...........",
    ".....U.....",
    "...........",
    "...........",
    "..L.....R..",
    "...........",
    "...........",
    ".....D.....",
    "...........",
    "...........",
  },
}

newlevel.correct_num = 4

newlevel.CircleColor = { 1, 7, 7, { 3, 7 } }

newlevel.hint = {
  { x = 2, y = 1 },
  { x = 2, y = 3 },
}
function newlevel.checkVictory()
  FloodFill()
  local ans = true
  local ans2 = true
  local cnt = {}
  for i = 1, len(FloodFillRes[currentPanel]) do
    cnt[i] = 0
  end
  correct[currentPanel][1] = isCover("ULDR")
  for i = 1, mapW[currentPanel] do
    for j = 1, mapH[currentPanel] do
      if map[currentPanel][i][j].str == "U" then
        if visit_grid[currentPanel][i][j + 1] or visit_grid[currentPanel][i][j - 1] then
          ans = false
        else
          if FloodFillAns[currentPanel][i][j + 1] == FloodFillAns[currentPanel][i][j - 1] then
            ans2 = false
          else
            cnt[FloodFillAns[currentPanel][i][j - 1]] = cnt[FloodFillAns[currentPanel][i][j - 1]] + 1
            cnt[FloodFillAns[currentPanel][i][j + 1]] = cnt[FloodFillAns[currentPanel][i][j + 1]] - 1
          end
        end
      end
      if map[currentPanel][i][j].str == "D" then
        if visit_grid[currentPanel][i][j + 1] or visit_grid[currentPanel][i][j - 1] then
          ans = false
        else
          if FloodFillAns[currentPanel][i][j + 1] == FloodFillAns[currentPanel][i][j - 1] then
            ans2 = false
          else
            cnt[FloodFillAns[currentPanel][i][j - 1]] = cnt[FloodFillAns[currentPanel][i][j - 1]] - 1
            cnt[FloodFillAns[currentPanel][i][j + 1]] = cnt[FloodFillAns[currentPanel][i][j + 1]] + 1
          end
        end
      end
      if map[currentPanel][i][j].str == "L" then
        if visit_grid[currentPanel][i + 1][j] or visit_grid[currentPanel][i - 1][j] then
          ans = false
        else
          if FloodFillAns[currentPanel][i + 1][j] == FloodFillAns[currentPanel][i - 1][j] then
            ans2 = false
          else
            cnt[FloodFillAns[currentPanel][i - 1][j]] = cnt[FloodFillAns[currentPanel][i - 1][j]] + 1
            cnt[FloodFillAns[currentPanel][i + 1][j]] = cnt[FloodFillAns[currentPanel][i + 1][j]] - 1
          end
        end
      end
      if map[currentPanel][i][j].str == "R" then
        if visit_grid[currentPanel][i + 1][j] or visit_grid[currentPanel][i - 1][j] then
          ans = false
        else
          if FloodFillAns[currentPanel][i + 1][j] == FloodFillAns[currentPanel][i - 1][j] then
            ans2 = false
          else
            cnt[FloodFillAns[currentPanel][i - 1][j]] = cnt[FloodFillAns[currentPanel][i - 1][j]] - 1
            cnt[FloodFillAns[currentPanel][i + 1][j]] = cnt[FloodFillAns[currentPanel][i + 1][j]] + 1
          end
        end
      end
    end
  end
  correct[currentPanel][2] = ans
  correct[currentPanel][3] = ans2
  local ans3 = true
  for i = 1, len(cnt) do
    ans3 = ans3 and (cnt[i] == 0)
  end
  correct[currentPanel][4] = ans3
end
return newlevel
