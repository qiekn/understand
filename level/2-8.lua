--half is cover, each type is fully covered or not covered

newlevel = {}

newlevel.level_str = {
  { "T U" },
  { "C C", "   ", "S S" },
  { "CCC", "SS ", "U  " },
  { "TTTT", "CCC ", "SS  ", "U   " },
  { "TTTTTTT", "SSSSSS ", "CCCCC  ", "UUUU   ", "DDD    ", "RR     ", "L      " },
}

newlevel.correct_num = 2
newlevel.hint = {
  { x = 1, y = 1 },
  { x = 2, y = 1 },
}

function newlevel.checkVictory()
  CountShape()
  local tot = 0
  local tot2 = 0
  local ans = true
  for k, v in pairs(shape_cnt) do
    tot = tot + v
    if shape_cover_cnt[k] ~= nil then
      tot2 = tot2 + shape_cover_cnt[k]
      if shape_cover_cnt[k] ~= v then
        ans = false
      end
    end
  end
  correct[currentPanel][1] = ans
  correct[currentPanel][2] = tot == tot2 * 2
end

newlevel.text = "Total amount matters."
return newlevel
