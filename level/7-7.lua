newlevel={}

--arrow is greater than

newlevel.level_str={
  {"   ",
   " U ",
   "   "},
  {"   ",
   " L ",
   "   "},
  {"  ",
   " D",
   "  "},
  {"    ",
   " R  ",
   "    "},
  {"   ",
   " L ",
   "   ",
   " L ",
   "   "},
  {"   ",
   " D ",
   "   ",
   " U ",
   "   "},
  {" R ",
   "   ",
   "   ",
   "   ",
   " L "},
  {" R ",
   "   ",
   "   ",
   "   ",
   " R "},
  {" R   ",
   "     ",
   " L   ",
   "     ",
   "     "},
  {"     ",
   "  U  ",
   "     ",
   "  R  ",
   "     "},
  {"     ",
   "  R  ",
   " D U ",
   "  L  ",
   "     "}
}

newlevel.correct_num=3

newlevel.hint={
  {x=1,y=1},
  {x=1,y=2},
  {x=3,y=2}
}
function newlevel.checkVictory()
  local function getsize(i,j)
    return len(FloodFillRes[currentPanel][FloodFillAns[currentPanel][i][j]])
  end

  FloodFill()
  local ans=true
  local ans2=true
  correct[currentPanel][1]=isCover("all")
  for i=1,mapW[currentPanel]do
    for j=1,mapH[currentPanel]do
      if map[currentPanel][i][j].str=="U" then
        if visit_grid[currentPanel][i][j+1] or visit_grid[currentPanel][i][j-1] then
          ans=false
        else
          if getsize(i,j+1)<=getsize(i,j-1) then
            ans2=false
          end
        end
      end
      if map[currentPanel][i][j].str=="D" then
        if visit_grid[currentPanel][i][j+1] or visit_grid[currentPanel][i][j-1] then
          ans=false
        else
          if getsize(i,j+1)>=getsize(i,j-1)then
            ans2=false
          end
        end
      end
      if map[currentPanel][i][j].str=="L" then
        if visit_grid[currentPanel][i+1][j] or visit_grid[currentPanel][i-1][j] then
          ans=false
        else
          if getsize(i+1,j)<=getsize(i-1,j) then
            ans2=false
          end
        end
      end
      if map[currentPanel][i][j].str=="R" then
        if visit_grid[currentPanel][i+1][j] or visit_grid[currentPanel][i-1][j] then
          ans=false
        else
          if getsize(i+1,j)>=getsize(i-1,j) then
            ans2=false
          end
        end
      end
    end
  end
  correct[currentPanel][2]=ans
  correct[currentPanel][3]=ans2
end
return newlevel
