--cover is rectangle, all is covered once

newlevel = {}

newlevel.level_str = {
  { "CCC", "SS ", "U  " },
  { "U S", " C ", "U S" },
  { "C S", "   ", "U T" },
  { "CS U", "   T", "T   ", "U SC" },
  { " CT ", "C  T", "U  S", " US " },
  { "..C..", ".C.T.", "S.C.T", ".S.U.", "..U.." },
}

newlevel.correct_num = 3

newlevel.hint = {
  { x = 1, y = 1 },
  { x = 1, y = 3 },
}
newlevel.CircleColor = { 2, 2, 4 }

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
  correct[currentPanel][3] = IsRectangle(visit[currentPanel]) ~= -1
end
return newlevel
