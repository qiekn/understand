newlevel = {}

--Area Size Equals Length

newlevel.level_str = {
  { "C S", " U " },
  { " C ", "U U", " S " },
  { " C U", "    ", "U S " },
  { " C  ", "U   ", "  S " },
  { ".C...", "U...U", "...S." },
  { "  C   ", "U    U", "   S  " },
  { "   C   ", "U     U", "   S   " },
  {
    "        ",
    "        ",
    "        ",
    "        ",
    "        ",
    "   U    ",
    "   CS  U",
    "        ",
    "        ",
  },
  {
    "U          U",
    "            ",
    "            ",
    "            ",
    "C           ",
    "            ",
    "           S",
    "U           ",
  },
}

newlevel.correct_num = 5

newlevel.hint = {
  { x = 1, y = 1 },
  { x = 3, y = 1 },
}

function newlevel.checkVictory()
  FloodFill()
  correct[currentPanel][1] = isStart("C")
  correct[currentPanel][2] = isEnd("S")
  correct[currentPanel][3] = isBlock("U")
  local ans = true
  local ans2 = true
  for i = 1, len(FloodFillRes[currentPanel]) do
    if len(FloodFillRes[currentPanel][i]) ~= len(visit[currentPanel]) then
      ans = false
    end
    if FloodFillShapeCount[currentPanel][i]["U"] ~= 1 then
      ans2 = false
    end
  end
  correct[currentPanel][4] = ans2
  correct[currentPanel][5] = ans
end

newlevel.text = "This level requires calculation."
return newlevel
