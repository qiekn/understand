-- area is shape, extended

newlevel = {}

newlevel.level_str = {
  { "  ", " #1" },
  { "   ", "   ", "  #1" },
  { "    ", "    ", "    ", "   #1" },
  { "#1   ", "    ", "    ", "   #1" },
  { "#1    ", "     ", "     ", "     ", "    #1" },
  { "#2   ", "    ", "    ", "   #2" },
  { "#2     ", "      ", "      ", "      ", "      ", "#1    #3" },
  {
    "#1      #1",
    "        ",
    "        ",
    "        ",
    "        ",
    "        ",
    "        ",
    "#1      #1",
  },
}

function newlevel.LoadLevel()
  tetris = {}
  tetris["1"] = {
    "1",
  }
  tetris["2"] = {
    "11",
  }
  tetris["3"] = {
    "11",
    "11",
  }
end

newlevel.correct_num = 4

newlevel.hint = {
  { x = 1, y = 2 },
  { x = 1, y = 1 },
  { x = 2, y = 1 },
}
function newlevel.checkVictory()
  ans = true
  ans2 = true
  local tmp = {}
  FloodFill()
  for i = 1, mapW[currentPanel] do
    for j = 1, mapH[currentPanel] do
      if map[currentPanel][i][j].str == "#" and not visit_grid[currentPanel][i][j] then
        ans3 = false
        for k = 1, 10 do
          if
            AreaMirror(
              BoostArea(ToArea(tetris[map[currentPanel][i][j].char]), k),
              FloodFillRes[currentPanel][FloodFillAns[currentPanel][i][j]],
              "same"
            )
          then
            ans3 = true
            if tmp[k] == nil then
              tmp[k] = 1
            else
              ans2 = false
            end
          end
        end
        if not ans3 then
          ans = false
        end
      end
    end
  end
  ans3 = true
  for i = 1, len(FloodFillRes[currentPanel]) do
    if FloodFillShapeCount[currentPanel][i]["#"] ~= 1 then
      ans3 = false
    end
  end
  correct[currentPanel][1] = isBlock("#")
  correct[currentPanel][2] = ans3
  correct[currentPanel][3] = ans
  correct[currentPanel][4] = ans2
end

newlevel.text = "Board 2 has 3 solutions."

return newlevel
