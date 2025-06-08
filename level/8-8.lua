-- shape form line 2

newlevel = {}

tetris = {}

newlevel.level_str = {
  { "  ", " #3" },
  { "   ", "  #4" },
  { "#2  ", "   ", "   " },
  { "#2..", "...", "...", "..#2" },
  { "#3..#3", "...." },
  { "#5..#3", "...." },
  { "#6..#6", "....", "....", "...." },
  { "#7..#8", "....", "....", "...." },
  { "#9..#3", "....", "....", "#5..." },
  { "#a...#c", ".....", "..#b..", ".....", "#c...#a" },
}
function newlevel.LoadLevel()
  tetris = {}
  tetris["a"] = {
    "1",
    "1",
    "1",
  }
  tetris["b"] = {
    "1",
    "1",
  }
  tetris["c"] = {
    "11",
    "11",
  }
  tetris["d"] = {
    "111",
    "111",
  }
  tetris["1"] = {
    "1",
  }
  tetris["2"] = {
    "11",
    "11",
  }
  tetris["3"] = {
    "11",
  }
  tetris["4"] = {
    "111",
  }
  tetris["5"] = {
    "1111",
  }
  tetris["6"] = {
    "001",
    "111",
  }
  tetris["7"] = {
    "010",
    "111",
  }
  tetris["8"] = {
    "111",
    "010",
  }
  tetris["9"] = {
    "101",
    "111",
  }
end

newlevel.correct_num = 2

newlevel.hint = {
  { x = 1, y = 1 },
  { x = 2, y = 1 },
}
function newlevel.checkVictory()
  ans = true
  FloodFill()
  local shapes = {}
  for i = 1, len(FloodFillRes[currentPanel]) do
    for j = 1, len(FloodFillRes[currentPanel][i]) do
      if map[currentPanel][FloodFillRes[currentPanel][i][j].x][FloodFillRes[currentPanel][i][j].y].str == "#" then
        table.insert(
          shapes,
          ToArea(tetris[map[currentPanel][FloodFillRes[currentPanel][i][j].x][FloodFillRes[currentPanel][i][j].y].char])
        )
      end
    end
  end
  local area = {}
  for i = 1, len(visit[currentPanel]) do
    table.insert(area, visit[currentPanel][i])
  end
  correct[currentPanel][1] = isBlock("#")
  correct[currentPanel][2] = tetris_solve(area, shapes, false)
end

newlevel.text = "9-6 and 9-7 focus on the same thing, but in a different perspective."

newlevel.tetris = tetris

return newlevel
