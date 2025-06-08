-- shape adds up to area 8-4

newlevel = {}

newlevel.level_str = {
  { "  ", " #1" },
  { "   ", "   ", "  #2" },
  { "  #2", "   ", "   ", "   ", "#2  " },
  { "#1#1 ", "   " },
  { "#3 #1", "   " },
  { "#3#1 ", "   " },
  { " #4 ", " #1 " },
  { " #2 ", " #1 " },
  { " #2#2", "   ", "   ", "   ", "   " },
  { "     ", "#x    ", "    #6", " #y   " },
  { "   ", "#3#4 ", "   " },
  { "  ", " #3", " #a" },
  { "#5 #5  ", "     ", "    #6" },
  { "     ", "     ", "     ", "#8 #2 #9" },
}

function newlevel.LoadLevel()
  tetris = {}
  tetris["1"] = {
    "1",
  }
  tetris["x"] = {
    "1111",
  }
  tetris["y"] = {
    "1",
    "1",
    "1",
  }
  tetris["2"] = {
    "11",
    "11",
  }
  tetris["3"] = {
    "11",
  }
  tetris["a"] = {
    "1",
    "1",
  }
  tetris["4"] = {
    "11",
    "10",
  }
  tetris["5"] = {
    "1",
    "1",
    "1",
  }
  tetris["6"] = {
    "111",
  }
  tetris["7"] = {
    "11",
  }
  tetris["8"] = {
    "010",
    "111",
  }
  tetris["9"] = {
    "111",
    "010",
  }
end

newlevel.correct_num = 2

newlevel.hint = {
  { x = 1, y = 2 },
  { x = 1, y = 1 },
  { x = 2, y = 1 },
}
function newlevel.checkVictory()
  ans = true
  FloodFill()
  for i = 1, len(FloodFillRes[currentPanel]) do
    local shapes = {}
    for j = 1, len(FloodFillRes[currentPanel][i]) do
      if map[currentPanel][FloodFillRes[currentPanel][i][j].x][FloodFillRes[currentPanel][i][j].y].str == "#" then
        table.insert(
          shapes,
          ToArea(tetris[map[currentPanel][FloodFillRes[currentPanel][i][j].x][FloodFillRes[currentPanel][i][j].y].char])
        )
      end
    end
    --    rPrint(shapes)
    if len(shapes) > 0 then
      if not tetris_solve(FloodFillRes[currentPanel][i], shapes, false) then
        ans = false
      end
    end
  end
  correct[currentPanel][1] = isBlock("#")
  correct[currentPanel][2] = ans
end

newlevel.text = "Yet another stolen idea from The Witness."

return newlevel
