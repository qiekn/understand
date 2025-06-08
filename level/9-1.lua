-- triangle is turn

newlevel={}


newlevel.level_str={
  {"C T",
   "   ",
   "  S"},
  {"C  ",
   " T ",
   "  S"},
  {"C T",
   " T ",
   "  S"},
  {"C..T",
   "..T.",
   ".T..",
   "T..S"},
  {"C...",
   ".TT.",
   ".TT.",
   "...S"},
  {"..T..",
   ".T.T.",
   "C.T.S",
   ".T.T.",
   "..T.."}
}

newlevel.correct_num=4

newlevel.hint={
  {x=1,y=1},
  {x=3,y=1},
  {x=3,y=3}
}
function newlevel.checkVictory()
  correct[currentPanel][1]=isStart("C")
  correct[currentPanel][2]=isEnd("S")
  correct[currentPanel][3]=isCover("T")
  GetDirection()
  local ans=true
  for i=1,len(visit[currentPanel])do
    if i==1 or i==len(visit[currentPanel])then
      if map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str=="T" then
        ans=false
      end
    else
      if map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str=="T" and direction[i-1]==direction[i] then
        ans=false
      end
    end
  end
  correct[currentPanel][4]=ans
end

return newlevel
