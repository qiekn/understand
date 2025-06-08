-- area has three empty

newlevel={}

newlevel.level_str={
  {"C  ",
   "   ",
   "  S"},
  {"   ",
   "C S",
   "   "},
  {"C.S",
   "...",
   "S.C"},
  {"C.S",
   ".C.",
   "S.C"},
  {"C...C",
   ".C.C.",
   "S.C.S",
   ".C.C.",
   "C...C"},
  {"C.C.S.S"},
  {".....",
   "CS.SC",
   "....."},
}

newlevel.correct_num=3

function newlevel.checkVictory()
  correct[currentPanel][1]=isStart("C")
  correct[currentPanel][2]=isEnd("S")
  local cnt=0
  for i=1,len(visit[currentPanel])do
    if map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str==" "then
      cnt=cnt+1
    end
  end
  correct[currentPanel][3]=(cnt==3)
end

newlevel.hint={
  {x=1,y=1},
  {x=3,y=1},
  {x=3,y=3}
}
return newlevel
