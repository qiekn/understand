-- space is not turn

newlevel = {}

newlevel.level_str = {
  { "TT", " T" },
  { "T T", "   ", "  T" },
  { "T T", "TT ", "  T" },
  { "T.T", "T..", ".TT" },
  { "T...T", ".....", "T.T.T", ".....", "..T.." },
  { "T..T.", "T...T", "T.T..", ".....", "..TTT" },
  { "TT.TT", "TTTTT", ".T.T.", "TTTTT", "TT.TT" },
}

newlevel.correct_num = 2

newlevel.hint = {
  { x = 1, y = 1 },
  { x = 2, y = 1 },
  { x = 2, y = 2 },
}
function newlevel.checkVictory()
  correct[currentPanel][1] = isCover("all")
  GetDirection()
  local ans = 0
  for i = 2, len(visit[currentPanel]) - 1 do
    if
      direction[i - 1] ~= direction[i]
      and map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str == " "
    then
      ans = ans + 1
    end
  end
  correct[currentPanel][2] = ans == 0
end
return newlevel
