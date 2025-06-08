-- number equals adjacent cover

newlevel={}


newlevel.level_str={
  {"   ",
   " 1 ",
   "   "},
   {"   ",
    " 2 ",
    "   "},
  {"   ",
   " 4 ",
   "   "},
  {" 2 ",
   "   ",
   " 2 "},
  {"     ",
   " 3 3 ",
   "     "},
  {"     ",
   " 2 2 ",
   "     ",
   " 2 3 ",
   "     "},
  {"     ",
   " 4 3 ",
   "     ",
   " 1 2 ",
   "     "},
  {"     ",
   " 3 3 ",
   "     ",
   " 3 2 ",
   "     "},
  {"  1  ",
   " 1   ",
   "1   1",
   "   1 ",
   "  1  "},
  {"       ",
   " 2 2 2 ",
   "       ",
   " 2   2 ",
   "       ",
   " 2 2 2 ",
   "       "},
   {"       ",
    " 3 3 3 ",
    "       ",
    " 3   3 ",
    "       ",
    " 3 1 3 ",
    "       "},
}

newlevel.correct_num=2

newlevel.hint={
  {x=1,y=1},
  {x=2,y=1}
}
function newlevel.checkVictory()
  correct[currentPanel][1]=isBlock("all")
  local ans=true
  for i=1,mapW[currentPanel]do
    for j=1,mapH[currentPanel]do
      if map[currentPanel][i][j].str=="~" then
        local cnt=0
        if i>1 then
          if visit_grid[currentPanel][i-1][j] then
            cnt=cnt+1
          end
        end
        if j>1 then
          if visit_grid[currentPanel][i][j-1] then
            cnt=cnt+1
          end
        end
        if i<mapW[currentPanel] then
          if visit_grid[currentPanel][i+1][j] then
            cnt=cnt+1
          end
        end
        if j<mapH[currentPanel] then
          if visit_grid[currentPanel][i][j+1] then
            cnt=cnt+1
          end
        end
        if cnt~=map[currentPanel][i][j].num then
          ans=false
        end
      end
    end
  end
  correct[currentPanel][2]=ans
end
return newlevel
