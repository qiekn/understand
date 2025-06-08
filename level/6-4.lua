-- reverse, oct is center

newlevel = {}

newlevel.level_str = {
  { "CTS" },
  { "CTS", " T " },
  { "CT ", " T ", " TS" },
  { "C    ", "     ", "  T  ", "     ", "    S" },
  { "C    ", " T   ", "  S  ", "     ", "    S" },
  { "C T S S" },
  { "   ", " T ", "C S" },
  { "     ", "CC   ", "  T  ", "     ", "    S" },
  { "     ", "     ", "     ", "   TS", "   C " },
  { "     ", "CTTTS", "     " },
  { "........", ".......S", "....T...", "........", "..C.T..S", "........", "........" },
  { "...........", "...........", "...CT.TS...", "...........", "..........." },
}

newlevel.correct_num = 4

function newlevel.checkVictory()
  correct[currentPanel][1] = isStart("C")
  correct[currentPanel][2] = isEnd("S")
  CountShape()
  correct[currentPanel][3] = (shape_cover_cnt["T"] == 1)
  local xx = 0
  local yy = 0
  local ans = true
  for i = 1, len(visit[currentPanel]) do
    if Shape(visit[currentPanel][i]) == "T" then
      xx = visit[currentPanel][i].x
      yy = visit[currentPanel][i].y
      ans = ans and AreaMirror(visit[currentPanel], visit[currentPanel], xx * 2, yy * 2, "reverse")
    end
  end
  correct[currentPanel][4] = ans
end

newlevel.hint = {
  { x = 1, y = 1 },
  { x = 3, y = 1 },
}
return newlevel
