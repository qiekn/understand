-- number equals following space

newlevel={}


newlevel.level_str={
  {" 1 2  "},
  {"1 1",
   "   ",
   "1 1"},
  {"2 2",
   "    ",
   " 2 "},
  {"   ",
   "123",
   "   "},
  {"     ",
   "  1  ",
   "3   4",
   "  2  ",
   "     "},
  {"     ",
   "    5",
   " 52 1",
   "  1  ",
   "2  2 "}
}

newlevel.correct_num=2

newlevel.hint={
  {x=2,y=1},
  {x=6,y=1}
}
function newlevel.checkVictory()
  correct[currentPanel][1]=isCover("~")
  correct[currentPanel][2]=true
  local next=0
  for i=1,len(visit[currentPanel])do
    if map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str=="~" then
      if next~=0 and next~=i then
        correct[currentPanel][2]=false
      end
      next=i+map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].num+1
    end
  end
  if next~=0 and next~=len(visit[currentPanel])+1 then
    correct[currentPanel][2]=false
  end
end
return newlevel
