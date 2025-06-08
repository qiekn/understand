--  circle is area corner

newlevel={}


newlevel.level_str={
  {"S  ",
   " C ",
   "   "},
  {"S  S",
   " CC ",
   "    "},
  {"S   ",
   "    ",
   "  C ",
   "    "},
  {"S   ",
   " C  ",
   "  C ",
   "    "},
  {".......",
   ".......",
   "..C.C..",
   ".......",
   "..C.C..",
   ".......",
   "......."},
  {".......",
   "...C...",
   ".......",
   ".C...C.",
   ".......",
   "...C...",
   "......."},
  {"     ",
   "   C ",
   "  S  ",
   " C   ",
   "     "},
  {"     ",
   " S C ",
   "     ",
   " C S ",
   "     "},
  {".......",
   ".......",
   "..C.C..",
   "...S...",
   "..C.C..",
   ".......",
   "......."},
  {".......",
   ".C...C.",
   ".......",
   "...C...",
   ".......",
   ".C...C.",
   "......."}
}

newlevel.correct_num=4

newlevel.hint={
  {x=1,y=1},
  {x=3,y=1},
  {x=3,y=3}
}
function newlevel.checkVictory()
  FloodFill()
  correct[currentPanel][1]=isCover("S")
  correct[currentPanel][2]=isBlock("C")
  correct[currentPanel][3]=len(FloodFillRes[currentPanel])==1
  local ans=true
  for i=1,mapW[currentPanel]do
    for j=1,mapH[currentPanel]do
      if map[currentPanel][i][j].str=="C" and visit_grid[currentPanel][i][j]==false then
        local i1=0
        local i2=0
        if visit_grid[currentPanel][i][j+1] then
          i1=i1+1
        end
        if visit_grid[currentPanel][i][j-1] then
          i1=i1+1
        end
        if visit_grid[currentPanel][i-1][j] then
          i2=i2+1
        end
        if visit_grid[currentPanel][i+1][j] then
          i2=i2+1
        end
        if i1~=1 or i2~=1 then
          ans=false
        end
      end
    end
  end
  correct[currentPanel][4]=ans
end
return newlevel
