-- shape must rotate
newlevel = {}

function newlevel.LoadLevel()
  tetris = {}
  tetris["b"] = {
    "011",
    "110",
  }
  tetris["c"] = {
    "11",
    "11",
  }
  tetris["1"] = {
    "1",
  }
  tetris["2"] = {
    "11",
  }
  tetris["d"] = {
    "1",
    "1",
  }
  tetris["9"] = {
    "11",
    "11",
  }
  tetris["3"] = {
    "01",
    "11",
  }
  tetris["6"] = {
    "111",
    "001",
  }
  tetris["7"] = {
    "111",
    "100",
  }
  tetris["8"] = {
    "11",
    "10",
  }
  tetris["4"] = {
    "111",
    "010",
  }
  tetris["5"] = {
    "01",
    "11",
    "01",
  }
  tetris["8"] = {
    "10",
    "11",
    "10",
  }
end

newlevel.level_str = {
  { "  ", " #1" },
  { "  ", " #2" },
  { "  ", " #3" },
  { "#3 ", "  " },
  { "   ", "  #4", "   " },
  { "  #8  ", "     ", "     ", "  #5  " },
  { "   #7 ", "     ", "     ", " #6   " },
  { "......", ".#2..#b.", "......", "......", ".#c..#d.", "......" },
}

newlevel.correct_num = 2

newlevel.hint = {
  { x = 1, y = 2 },
  { x = 1, y = 1 },
  { x = 2, y = 1 },
}
function newlevel.checkVictory()
  ans = true
  FloodFill()
  for i = 1, mapW[currentPanel] do
    for j = 1, mapH[currentPanel] do
      if map[currentPanel][i][j].str == "#" and not visit_grid[currentPanel][i][j] then
        if
          not AreaMirror(
            ToArea(tetris[map[currentPanel][i][j].char]),
            FloodFillRes[currentPanel][FloodFillAns[currentPanel][i][j]],
            "clockwise"
          )
        then
          ans = false
        end
      end
    end
  end
  correct[currentPanel][1] = isBlock("#")
  correct[currentPanel][2] = ans
end

newlevel.text = "Some polyominoes are symmetrical."

return newlevel
