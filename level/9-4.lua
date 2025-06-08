-- always turn

newlevel = {}

newlevel.level_str = {
  { "TT", " T" },
  { "T..", "..T" },
  { "   ", "TTT", "   " },
  { " T ", "TTT", " T " },
  { "T...", "..T.", "....", "T..." },
  { "..T..", ".....", "T.T.T", ".....", "..T.." },
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
  local ans = true
  for i = 2, len(visit[currentPanel]) - 1 do
    if direction[i - 1] == direction[i] then
      ans = false
    end
  end
  correct[currentPanel][2] = ans
end
return newlevel
