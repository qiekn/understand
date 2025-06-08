-- number equals area size

newlevel={}


newlevel.level_str={
  {"1  "},
  {"2  "},
  {"1 2",
   "   "},
  {"4  ",
   "   ",
   "  1"},
  {"1 1",
   "   ",
   "   "},
  {"3 3",
   "   ",
   "   "},
  {"4 4",
   "   ",
   "   "},
  {"4   2",
   "     ",
   "     ",
   "5  1 ",
   "     "},
  {"9   9",
   "     ",
   "  9  ",
   "     ",
   "9   9"}
}

newlevel.correct_num=2

newlevel.hint={
  {x=2,y=1},
  {x=3,y=1}
}
function newlevel.checkVictory()
  correct[currentPanel][1]=isBlock("~")
  local ans=true
  FloodFill()
  for i=1,len(FloodFillRes[currentPanel]) do
    for j=1,len(FloodFillRes[currentPanel][i])do
      if map[currentPanel][FloodFillRes[currentPanel][i][j].x][FloodFillRes[currentPanel][i][j].y].str=="~" then
        if map[currentPanel][FloodFillRes[currentPanel][i][j].x][FloodFillRes[currentPanel][i][j].y].num~=len(FloodFillRes[currentPanel][i]) then
          ans=false
        end
      end
    end
  end
  correct[currentPanel][2]=ans
end
return newlevel
