--even is cover, odd is block

newlevel = {}

newlevel.level_str = {
  { "CSC", "   " },
  { "T T T T", " U U U " },
  { "CCC", "SS ", "U  " },
  { "C C", "USU ", "C C" },
  { "CSSUT", "     ", "SUTTS" },
}

newlevel.correct_num = 2

newlevel.text = "Some of the symbols must be covered, while some others must not."

function newlevel.checkVictory()
  CountShape()
  local mm = 0
  ans1 = ""
  ans2 = ""
  for k, v in pairs(shape_cnt) do
    if v % 2 == 0 then
      ans1 = ans1 .. k
    else
      ans2 = ans2 .. k
    end
  end
  correct[currentPanel][1] = isCover(ans1)
  correct[currentPanel][2] = isBlock(ans2)
end

newlevel.hint = {
  { x = 1, y = 1 },
  { x = 1, y = 2 },
  { x = 3, y = 2 },
  { x = 3, y = 1 },
}
return newlevel
