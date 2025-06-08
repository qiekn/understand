-- reverse, any is center

newlevel = {}

newlevel.level_str = {
  { "CTS", "   " },
  { "C  ", " S " },
  { "   C", " S  " },
  { "...CTTS.", "........" },
  { "C   ", "    ", "    ", "S   " },
  { "C   ", " T  ", "    ", "  S " },
  { "C   ", "    ", "  T ", "  S " },
  { "    ", "  S ", "C   ", "    " },
  { "   T  ", "    S ", "      ", " C    ", "      ", "     T" },
}

newlevel.correct_num = 4

function newlevel.checkVictory()
  correct[currentPanel][1] = isStart("C")
  correct[currentPanel][2] = isEnd("S")
  correct[currentPanel][3] = isCover("T")
  area2 = {}
  for i = 1, mapW[currentPanel] do
    for j = 1, mapH[currentPanel] do
      if not visit_grid[currentPanel][i][j] then
        table.insert(area2, { x = i, y = j })
      end
    end
  end
  correct[currentPanel][4] =
    AreaMirror(visit[currentPanel], area2, mapW[currentPanel] + 1, mapH[currentPanel] + 1, "reverse")
end

newlevel.hint = {
  { x = 1, y = 1 },
  { x = 3, y = 1 },
}
return newlevel
