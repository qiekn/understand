--most is cover, least is block

newlevel = {}

newlevel.level_str = {
  { "CC", "S " },
  { "TUT", "   " },
  { "CCC", "SS ", "U  " },
  { "U S", " C ", "U S" },
  { "U S", "CC ", "S S" },
  { "TCOS", "OSTU" },
}

newlevel.correct_num = 2

newlevel.hint = {
  { x = 1, y = 1 },
  { x = 2, y = 1 },
}

newlevel.text = "The rules are not related to specific symbol."

function newlevel.checkVictory()
  CountShape()
  local mm = 0
  for k, v in pairs(shape_cnt) do
    if v > mm then
      mm = v
    end
  end
  ans1 = ""
  ans2 = ""
  for k, v in pairs(shape_cnt) do
    if v == mm then
      ans1 = ans1 .. k
    else
      ans2 = ans2 .. k
    end
  end
  correct[currentPanel][1] = isCover(ans1)
  correct[currentPanel][2] = isBlock(ans2)
end
return newlevel
