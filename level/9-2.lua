-- turn is four

newlevel = {}

newlevel.level_str = {
  { "C T", "   ", "  S" },
  { "C  ", "TTT", "  S" },
  { "T  ", " C ", "  S" },
  { "CTTS", ".TT." },
  { "C..S", ".TT.", ".TT.", "...." },
  { "C.T.", "...T", "T...", ".T.S" },
}

newlevel.correct_num = 4

newlevel.hint = {
  { x = 1, y = 1 },
  { x = 3, y = 1 },
  { x = 3, y = 2 },
  { x = 1, y = 2 },
  { x = 1, y = 3 },
  { x = 3, y = 3 },
}
function newlevel.checkVictory()
  correct[currentPanel][1] = isStart("C")
  correct[currentPanel][2] = isEnd("S")
  correct[currentPanel][3] = isCover("T")
  GetDirection()
  local ans = 0
  for i = 2, len(visit[currentPanel]) - 1 do
    if direction[i - 1] ~= direction[i] then
      ans = ans + 1
    end
  end
  print(ans)
  correct[currentPanel][4] = ans == 4
end
return newlevel
