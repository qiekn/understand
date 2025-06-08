-- sum equals area size

newlevel={}


newlevel.level_str={
  {"1 1",
   "   ",
   "   "},
  {"3 3",
   "   ",
   "   "},
  {"1  1",
   "    ",
   "1   "},
  {"1  3",
   "    ",
   "2   "},
  {"4   2",
   "     ",
   "     ",
   "5  1 ",
   "     "},
  {"  2  ",
   "2   2",
   "  2  "},
  {"     ",
   "     ",
   " 3   ",
   "  2  ",
   "   1 ",
   "     "}
}

newlevel.correct_num=4

newlevel.hint={
  {x=2,y=1},
  {x=2,y=2},
  {x=1,y=2},
  {x=1,y=3},
  {x=3,y=3},
  {x=3,y=2}
}
function newlevel.checkVictory()
  FloodFill()
  correct[currentPanel][1]=isBlock("~")
  correct[currentPanel][2]=len(FloodFillRes[currentPanel])>=2
  local ans2=true
  local sum=-1
  local ans=true
  for i=1,len(FloodFillRes[currentPanel]) do
    local s1=0
    for j=1,len(FloodFillRes[currentPanel][i])do
      if map[currentPanel][FloodFillRes[currentPanel][i][j].x][FloodFillRes[currentPanel][i][j].y].str=="~" then
        s1=s1+map[currentPanel][FloodFillRes[currentPanel][i][j].x][FloodFillRes[currentPanel][i][j].y].num
      end
    end
    if sum==-1 then
      sum=s1
    else
      if sum~=s1 then
        ans=false
      end
    end
    if s1~=len(FloodFillRes[currentPanel][i])then
      ans2=false
    end
  end
  correct[currentPanel][3]=ans2
  correct[currentPanel][4]=ans
end
return newlevel
