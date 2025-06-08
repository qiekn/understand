--corner is reverse

newlevel = {}

newlevel.level_str = {
  { "C  ", "   ", "  S" },
  { "C  ", "   ", " S " },
  { "C  ", "   ", "S  " },
  { " C ", "   ", " S " },
  { " CS ", "    ", "    ", "    " },
  { "     ", "     ", "     ", "  C S", "     " },
  { "     ", "     ", "   S ", "     ", "  C  " },
}

newlevel.correct_num = 4

newlevel.hint = {
  { x = 1, y = 1 },
  { x = 2, y = 1 },
  { x = 2, y = 3 },
  { x = 3, y = 3 },
}
newlevel.CircleColor = { 1, 1, 9, { 6, 9 } }

function newlevel.checkVictory()
  correct[currentPanel][1] = isStart("C")
  correct[currentPanel][2] = isEnd("S")

  local area = {}
  GetDirection()
  for i = 2, len(visit[currentPanel]) - 1 do
    if direction[i] ~= direction[i - 1] then
      table.insert(area, { x = visit[currentPanel][i].x, y = visit[currentPanel][i].y })
    end
  end
  correct[currentPanel][3] = len(area) >= 2
  correct[currentPanel][4] = AreaMirror(area, area, 1 + mapW[currentPanel], 1 + mapH[currentPanel], "reverse")
end
return newlevel
