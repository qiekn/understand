-- empty is octo+1

newlevel = {}

newlevel.level_str = {
  { "O  ", "   ", "  O" },
  { "O O", "   ", "  O" },
  { ".O.", "  O", "O  " },
  { ".....", ".O.O.", ".....", ".O.O.", "....." },
  { ".....", ".....", ".OOO.", ".....", "....." },
  { "..O..", ".....", ".O.O.", ".....", "..O.." },
}

newlevel.correct_num = 4

function newlevel.checkVictory()
  correct[currentPanel][1] = isStart("O")
  correct[currentPanel][2] = isEnd("O")
  correct[currentPanel][3] = isCover("O")
  local cnt = 0
  for i = 1, len(visit[currentPanel]) do
    if map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str == " " then
      cnt = cnt + 1
    else
      cnt = cnt - 1
    end
  end
  correct[currentPanel][4] = (cnt == 1)
end

newlevel.hint = {
  { x = 1, y = 1 },
  { x = 3, y = 1 },
  { x = 3, y = 3 },
}
return newlevel
