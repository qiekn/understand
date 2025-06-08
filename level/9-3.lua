-- always turn left

newlevel = {}

newlevel.level_str = {
  { "TC", " T" },
  { "   ", "TCT", "   " },
  { " T ", "TCT", " T " },
  { "....", ".TC.", ".CT.", "...." },
  { "..T..", "..C..", "T.T.T", ".C.C.", "..T.." },
  { "T...C", ".T.T.", ".CTC.", ".....", "T...T" },
}

newlevel.correct_num = 3

newlevel.hint = {
  { x = 1, y = 1 },
  { x = 1, y = 2 },
  { x = 2, y = 2 },
}
function newlevel.checkVictory()
  correct[currentPanel][1] = isCover("T")
  correct[currentPanel][2] = isBlock("C")
  GetDirection()
  local ans = true
  for i = 2, len(visit[currentPanel]) - 1 do
    if direction[i - 1] == "U" and direction[i] == "R" then
      ans = false
    end
    if direction[i - 1] == "R" and direction[i] == "D" then
      ans = false
    end
    if direction[i - 1] == "D" and direction[i] == "L" then
      ans = false
    end
    if direction[i - 1] == "L" and direction[i] == "U" then
      ans = false
    end
  end
  correct[currentPanel][3] = ans
end
return newlevel
