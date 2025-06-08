-- shapes adds up to empty space

newlevel = {}

function newlevel.LoadLevel()
  tetris = {}

  tetris["1"] = { "1" }
  tetris["2"] = { "11" }
  tetris["3"] = { "01", "11" }
  tetris["4"] = { "11", "10", "10" }
  tetris["5"] = { "010", "111", "010" }
  tetris["7"] = { "010", "111" }
  tetris["6"] = { "10", "11" }
  tetris["8"] = { "1", "1" }
  tetris["a"] = { "1", "1" }
  tetris["b"] = { "11", "10", "10" }
  tetris["c"] = { "10", "10", "11" }
  tetris["d"] = { "11", "01", "01" }
  tetris["e"] = { "111", "010" }
  tetris["f"] = { "11", "10" }
end

newlevel.level_str = {
  { "O.O", "#1..", "..#1", "O.O" },
  { "O..O", "#1..#3", "....", "O..O" },
  { "O..O#2.O", ".......", "O.#1O..O" },
  { "O..O", "....", "....", "#1.." },
  { "#1..", "...", "#2.." },
  { "#2..#1", "....", "....", "#1..#8" },
  { "O...#d", ".....", "..#e..", ".....", "#1...O" },
  { "O....O", "#f....#a", "......", "......", "#a....#b", "O....O" },
}

newlevel.correct_num = 3

newlevel.CircleColor = { 1, 3, 8 }

newlevel.hint = {
  { x = 2, y = 1 },
  { x = 2, y = 4 },
}
function newlevel.checkVictory()
  FloodFill()
  correct[currentPanel][1] = isBlock("all")
  local ans = true
  for i = 1, len(FloodFillShapeCount[currentPanel]) do
    for k, v in pairs(FloodFillShapeCount[currentPanel][i]) do
      if k ~= " " and k ~= "#" and v ~= 2 then
        ans = false
      end
    end
  end
  correct[currentPanel][2] = ans

  ans2 = true
  for i = 1, len(FloodFillRes[currentPanel]) do
    local shapes = {}
    local area = {}
    for j = 1, len(FloodFillRes[currentPanel][i]) do
      if map[currentPanel][FloodFillRes[currentPanel][i][j].x][FloodFillRes[currentPanel][i][j].y].str == "#" then
        table.insert(
          shapes,
          ToArea(tetris[map[currentPanel][FloodFillRes[currentPanel][i][j].x][FloodFillRes[currentPanel][i][j].y].char])
        )
      end
      if map[currentPanel][FloodFillRes[currentPanel][i][j].x][FloodFillRes[currentPanel][i][j].y].str == " " then
        table.insert(area, { x = FloodFillRes[currentPanel][i][j].x, y = FloodFillRes[currentPanel][i][j].y })
      end
    end
    if len(shapes) > 0 then
      if not tetris_solve(area, shapes, false) then
        ans2 = false
      end
    end
  end
  correct[currentPanel][3] = ans2
end

return newlevel
