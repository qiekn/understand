-- shape is line

newlevel = {}

newlevel.level_str = {
  { "  ", " #3" },
  { "   ", "  #6" },
  { "   ", "  #1" },
  { "#2  ", "   ", "   " },
  { "#1#1 ", "   " },
  { "#s....#s", "........" },
  { "#1 #1", "   " },
  { " #a  ", "   #1" },
  { " #4  ", "   #1" },
  { "  #8 ", "#7   ", "  #a ", "    " },
  { "#s....#s", "......", "......", "......", "......", "#s....#s" },
  { "    #u", "  #v  ", "     ", " #w   ", "   #x " },
}

function newlevel.LoadLevel()
  tetris = {}
  tetris["u"] = {
    "1",
    "1",
    "1",
    "1",
  }
  tetris["v"] = {
    "10",
    "11",
  }
  tetris["w"] = {
    "111",
    "001",
    "001",
  }
  tetris["x"] = {
    "001",
    "111",
  }
  tetris["1"] = {
    "1",
  }
  tetris["2"] = {
    "011",
    "110",
  }
  tetris["3"] = {
    "11",
  }
  tetris["a"] = {
    "10",
    "11",
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
    "01",
    "01",
  }
  tetris["8"] = {
    "11",
    "01",
  }

  tetris["s"] = {
    "11",
    "11",
  }
end

newlevel.correct_num = 2

newlevel.hint = {
  { x = 1, y = 1 },
  { x = 2, y = 1 },
}
function newlevel.checkVictory()
  local function DoIt(shapes, isable, n1, n2)
    if n2 == len(shapes) then
      return true
    end
    for i = 1, len(shapes) do
      if isable[i] then
        isable[i] = false
        local area = {}
        for j = n1, n1 + len(shapes[i]) - 1 do
          table.insert(area, { x = visit[currentPanel][j].x, y = visit[currentPanel][j].y })
        end
        rPrint(area)
        rPrint(shapes[i])
        if AreaMirror(area, shapes[i], "same") then
          if DoIt(shapes, isable, n1 + len(shapes[i]), n2 + 1) then
            return true
          end
        end
        isable[i] = true
      end
    end
    return false
  end
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
  local sum = 0
  local able = {}
  for i = 1, len(shapes) do
    able[i] = true
    sum = sum + len(shapes[i])
  end
  local area = {}
  correct[currentPanel][1] = isBlock("#")
  if sum == len(visit[currentPanel]) then
    correct[currentPanel][2] = DoIt(shapes, able, 1, 0)
  else
    correct[currentPanel][2] = false
  end
end

newlevel.text = "Area doens't matter this time."

return newlevel
