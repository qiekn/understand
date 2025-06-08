-- star is divide

newlevel = {}

newlevel.level_str = {
  { "C T", "   ", "  S" },
  { " T ", "C S", "   " },
  { "T  ", "   ", "C S" },
  { "TS", "  ", "C " },
  { "CT ", "   ", " TS" },
  { "CT ", " TT", "ST " },
  { "   ", "CT ", "T T", " TS", "   " },
  { "C.T..", ".....", "T.T.T", ".....", "..T.S" },
}

newlevel.correct_num = 4

newlevel.hint = {
  { x = 1, y = 1 },
  { x = 3, y = 1 },
  { x = 3, y = 3 },
}

function newlevel.checkVictory()
  correct[currentPanel][1] = isStart("C")
  correct[currentPanel][2] = isEnd("S")
  correct[currentPanel][3] = isCover("T")
  GetDirection()
  local ans = true
  for i = 1, len(visit[currentPanel]) do
    if i == 1 or i == len(visit[currentPanel]) then
      if map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str == "T" then
        ans = false
      end
    else
      if map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str == "T" then
        j1 = i - 1
        while j1 > 0 and direction[j1] == direction[i - 1] do
          j1 = j1 - 1
        end
        j2 = i
        while j2 < len(visit[currentPanel]) and direction[j2] == direction[i] do
          j2 = j2 + 1
        end
        if i - 1 - j1 ~= j2 - i then
          print(i - 1 - j1, j2 - i, j1, j2, i)
          ans = false
        end
      end
    end
  end
  correct[currentPanel][4] = ans
end
return newlevel
