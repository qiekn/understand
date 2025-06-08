-- shape adds up to area, shape can be rotate

newlevel = {}

newlevel.level_str = {
  { "  ", " #1" },
  { "  ", " #2" },
  { "  ", " #3" },
  { "#a  #2", "    " },
  { "    ", "#3  #4" },
  { "#5#5#5 ", "    ", "    ", "    ", "    " },
  { "     ", "#6   #6", "     " },
  { "    ", "    ", "#7#7#8#8", "    ", "    " },
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
    "10",
  }
  tetris["4"] = {
    "01",
    "11",
    "10",
  }
  tetris["5"] = {
    "111",
    "110",
  }
  tetris["6"] = {
    "111",
    "100",
  }
  tetris["7"] = {
    "011",
    "110",
  }
  tetris["8"] = {
    "111",
    "001",
  }

  tetris["a"] = {
    "10",
    "10",
    "11",
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
      if not tetris_solve(FloodFillRes[currentPanel][i], shapes, true) then
        ans = false
      end
    end
  end
  correct[currentPanel][1] = isBlock("#")
  correct[currentPanel][2] = ans
end

newlevel.text = "Yet another stolen idea from The Witness."

return newlevel
