-- number is visit order

newlevel={}


newlevel.level_str={
  {"123"},
  {"123",
   "654",
   "789"},
  {" 2",
   "43"},
  {"   ",
   " 5 "},
  {" 4 ",
   "   ",
   " 8 "},
  {"5  ",
   "   ",
   "9  "}
}

newlevel.correct_num=2

newlevel.hint={
  {x=1,y=1},
  {x=3,y=1}
}
function newlevel.checkVictory()
  correct[currentPanel][1]=isCover("~")
  correct[currentPanel][2]=true
  local num=0
  for i=1,len(visit[currentPanel])do
    if map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str=="~" then
      if map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].num~=i then
        correct[currentPanel][2]=false
      end
    end
  end
end
return newlevel
