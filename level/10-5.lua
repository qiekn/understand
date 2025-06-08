-- distance to nearest shape is number

newlevel = {}

newlevel.level_str = {
  { "2 2", "   " },
  { "2 2", "   ", " 3 " },
  { "2 2", "   ", "4  " },
  { "11  ", "    ", "2 2 ", "    ", "3  3" },
  { "3  3", "    ", "3  3", "    " },
  { "3  3", "    ", "5  5", "    " },
  { "......", ".3..5.", "......", "......", ".3..3.", "......" },
  { ".......", ".4...4.", ".......", ".......", ".......", ".8...6.", "......." },
}

newlevel.correct_num = 2

newlevel.hint = {
  { x = 1, y = 2 },
  { x = 3, y = 2 },
}
newlevel.CircleColor = { 1, 5 }

function newlevel.checkVictory()
  correct[currentPanel][1] = isBlock("all")
  FloodFill()
  --[[  local ans=true
  local ans2=true
  for i=1,len(FloodFillShapeCount[currentPanel]) do
    local ttt=0
    for k,v in pairs(FloodFillShapeCount[currentPanel][i]) do
      if k~=" " and k~="~" then
        ttt=ttt+1
      end
    end
    if ttt>1 then
      ans2=false
    end
  end
  correct[currentPanel][2]=ans2]]
  local ans3 = true
  for i = 1, mapW[currentPanel] do
    for j = 1, mapH[currentPanel] do
      if map[currentPanel][i][j].str == "~" and visit_grid[currentPanel][i][j] == false then
        vvv = {}
        for i1 = 1, mapW[currentPanel] do
          vvv[i1] = {}
          for j1 = 1, mapH[currentPanel] do
            vvv[i1][j1] = 10000
          end
        end
        vvv[i][j] = 0
        local flag = false
        local ll = 0

        while not flag do
          local f2 = false
          for i1 = 1, mapW[currentPanel] do
            for j1 = 1, mapH[currentPanel] do
              if vvv[i1][j1] == ll then
                if i1 > 1 and visit_grid[currentPanel][i1 - 1][j1] == false and vvv[i1 - 1][j1] == 10000 then
                  f2 = true
                  vvv[i1 - 1][j1] = ll + 1
                  if map[currentPanel][i1 - 1][j1].str ~= " " then
                    flag = true
                  end
                end
                if j1 > 1 and visit_grid[currentPanel][i1][j1 - 1] == false and vvv[i1][j1 - 1] == 10000 then
                  f2 = true
                  vvv[i1][j1 - 1] = ll + 1
                  if map[currentPanel][i1][j1 - 1].str ~= " " then
                    flag = true
                  end
                end
                if
                  i1 < mapW[currentPanel]
                  and visit_grid[currentPanel][i1 + 1][j1] == false
                  and vvv[i1 + 1][j1] == 10000
                then
                  f2 = true
                  vvv[i1 + 1][j1] = ll + 1
                  if map[currentPanel][i1 + 1][j1].str ~= " " then
                    flag = true
                  end
                end
                if
                  j1 < mapH[currentPanel]
                  and visit_grid[currentPanel][i1][j1 + 1] == false
                  and vvv[i1][j1 + 1] == 10000
                then
                  f2 = true
                  vvv[i1][j1 + 1] = ll + 1
                  if map[currentPanel][i1][j1 + 1].str ~= " " then
                    flag = true
                  end
                end
              end
            end
          end
          ll = ll + 1
          if f2 == false then
            flag = true
            ll = -1
          end
        end
        if ll ~= map[currentPanel][i][j].num then
          print(ll, i, j, map[currentPanel][i][j].num)
          ans3 = false
        end
      end
    end
  end
  correct[currentPanel][2] = ans3
end

return newlevel
