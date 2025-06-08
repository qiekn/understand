newlevel = {}

--arrow is visit first

newlevel.level_str = {
  { "   ", " D ", "   " },
  { "   ", " U ", "   ", " U ", "   " },
  { "   ", " L ", " R ", "   " },
  { "     ", " L R ", "     " },
  { "       ", "       ", "  UDU  ", "       ", "       " },
  { "     ", "  D  ", "     ", " R L ", "     " },
  { "      ", "      ", " U L  ", "      ", " R D  ", "      ", "      " },
}

newlevel.correct_num = 3

newlevel.hint = {
  { x = 2, y = 1 },
  { x = 1, y = 1 },
  { x = 1, y = 3 },
  { x = 2, y = 3 },
}
function newlevel.checkVictory()
  local ans = true
  local ans2 = true
  GetVisitOrder()
  correct[currentPanel][2] = isBlock("all")
  for i = 1, mapW[currentPanel] do
    for j = 1, mapH[currentPanel] do
      if map[currentPanel][i][j].str == "U" then
        if not visit_grid[currentPanel][i][j + 1] or not visit_grid[currentPanel][i][j - 1] then
          ans = false
        else
          if visit_order[i][j + 1] > visit_order[i][j - 1] then
            ans2 = false
          end
        end
      end
      if map[currentPanel][i][j].str == "D" then
        if not visit_grid[currentPanel][i][j + 1] or not visit_grid[currentPanel][i][j - 1] then
          ans = false
        else
          if visit_order[i][j + 1] < visit_order[i][j - 1] then
            ans2 = false
          end
        end
      end
      if map[currentPanel][i][j].str == "L" then
        if not visit_grid[currentPanel][i + 1][j] or not visit_grid[currentPanel][i - 1][j] then
          ans = false
        else
          if visit_order[i + 1][j] > visit_order[i - 1][j] then
            ans2 = false
          end
        end
      end
      if map[currentPanel][i][j].str == "R" then
        if not visit_grid[currentPanel][i + 1][j] or not visit_grid[currentPanel][i - 1][j] then
          ans = false
        else
          if visit_order[i + 1][j] < visit_order[i - 1][j] then
            ans2 = false
          end
        end
      end
    end
  end
  correct[currentPanel][1] = ans
  correct[currentPanel][3] = ans2
end
return newlevel
