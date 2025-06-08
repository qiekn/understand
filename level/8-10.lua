-- shape and area makes square 8-6

newlevel = {}

tetris = {}

newlevel.level_str = {
  { "  ", " #2" },
  { "  ", " #1" },
  { "  ", " #5" },
  { "   ", "   ", "  #6" },
  { "   ", "  #2" },
  { "   ", "  #1" },
  { "   ", "  #7" },
  { "#1  ", "   ", "  #1" },
  { "#1   ", "    ", "   #1" },
  { "#1 #8", "   ", "   " },
  { "#1  #8", "    ", "    " },
  { "#6..#6", "....", "#1..#1" },
  { ".....", "...#b.", ".....", ".#a...", "....." },
  { ".....", ".....", "#1.#2.#5" },
  { ".....", ".#2.#2.", ".....", ".#2.#2.", "....." },
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
    "111",
  }
  tetris["4"] = {
    "1111",
  }
  tetris["5"] = {
    "01",
    "11",
  }
  tetris["6"] = {
    "11",
    "11",
  }
  tetris["7"] = {
    "100",
    "110",
    "111",
  }
  tetris["8"] = {
    "100",
    "111",
  }
  tetris["a"] = {
    "10",
    "11",
    "10",
  }
  tetris["b"] = {
    "01",
    "11",
    "01",
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
  for i = 1, len(FloodFillRes[currentPanel]) do
    local shapes = {}
    local tot = 0
    for j = 1, len(FloodFillRes[currentPanel][i]) do
      if map[currentPanel][FloodFillRes[currentPanel][i][j].x][FloodFillRes[currentPanel][i][j].y].str == "#" then
        table.insert(
          shapes,
          ToArea(tetris[map[currentPanel][FloodFillRes[currentPanel][i][j].x][FloodFillRes[currentPanel][i][j].y].char])
        )
        tot = tot + len(getlast(shapes))
        print(tot)
      end
    end
    tot = tot + len(FloodFillRes[currentPanel][i])
    --    rPrint(shapes)
    local ans0 = false
    print(tot)
    for j = 1, 10 do
      if tot == j * j then
        area = {}
        for k = 1, j do
          for t = 1, j do
            table.insert(area, { x = k, y = t })
          end
        end
        table.insert(shapes, FloodFillRes[currentPanel][i])
        rPrint(area)
        rPrint(shapes)
        if tetris_solve(area, shapes, false) then
          ans0 = true
        end
      end
    end
    if not ans0 then
      ans = false
    end
  end
  correct[currentPanel][1] = isBlock("#")
  correct[currentPanel][2] = ans
end

newlevel.text = "Rule 2 is about area, not line."
newlevel.tetris = tetris

return newlevel
