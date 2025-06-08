-- number equals cover on the right

newlevel={}


newlevel.level_str={
  {"   ",
   " 1 ",
   "   "},
  {" 1 ",
   "   ",
   " 1 "},
  {"     ",
   "     ",
   "  2  ",
   "     ",
   "     "},
  {"     ",
   " 2 1 ",
   "     "},
  {"1  ",
   "2  ",
   "1  "},
   {"1   ",
    "2   ",
    "3   ",
    "2   ",
    "1   "},
  {"          ",
   " 4  2  2  ",
   " 3  3  1  ",
   "          "},
   {"4    ",
    "4    ",
    "3    ",
    "4    ",
    "4    ",
    "3    "},
}

newlevel.correct_num=2

newlevel.hint={
  {x=3,y=1},
  {x=3,y=3}
}
function newlevel.checkVictory()
  correct[currentPanel][1]=isBlock("all")
  local ans=true
  for i=1,mapW[currentPanel]do
    for j=1,mapH[currentPanel]do
      if map[currentPanel][i][j].str=="~" then
        local cnt=0
        for k=i+1,mapW[currentPanel]do
          if visit_grid[currentPanel][k][j]then
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
