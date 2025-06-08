-- number is adjacent

newlevel={}


newlevel.level_str={
  {"123"},
  {"1 2",
   " 3 "},
  {"4 2",
   "   ",
   "3 1"},
  {"    ",
   "1342",
   "    "},
  {"1  1",
   "    ",
   "    ",
   "2  2"},
  {"1.2",
   ".3.",
   "2.1"},
  {"1234",
   "    ",
   "    ",
   "1234"},
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
      if num~=0 then
        if math.abs(num-map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].num)~=1 then
          correct[currentPanel][2]=false
        end
      end
      num=map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].num
    end
  end
end
return newlevel
