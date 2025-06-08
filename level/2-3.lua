--one of each is cover

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
  { x = 1, y = 2 },
}

function newlevel.checkVictory()
  CountShape()
  local mm = 0
  ans1 = true
  ans2 = true
  for k, v in pairs(shape_cnt) do
    if shape_cover_cnt[k] == nil then
      ans2 = false
    elseif shape_cover_cnt[k] ~= 1 then
      ans1 = false
    end
  end
  correct[currentPanel][1] = ans1
  correct[currentPanel][2] = ans2
end

newlevel.text = "Most levels can be solved by trail and error."
return newlevel
