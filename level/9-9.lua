-- straight line contains 1 circle

newlevel={}


newlevel.level_str={
  {"C  ",
   " S ",
   "  C"},
  {" C ",
   " SC",
   "   "},
  {"C  ",
   "  C",
   " C "},
  {" C ",
   "CSC",
   " C "},
  {"SC ",
   "C C",
   " CS"},
  {"C C  ",
   " C C ",
   "  C C"},
  {"  C  ",
   "     ",
   "C C C",
   " C    ",
   "  C  "},
  {"..C.C.",
   "C.....",
   "......",
   "......",
   ".....C",
   ".C.C.."},
  {"..C.C.",
   "C.....",
   ".....C",
   "C.....",
   ".....C",
   ".C.C.."},
}

newlevel.correct_num=3

newlevel.hint={
  {x=1,y=1},
  {x=3,y=1},
  {x=3,y=3}
}

function newlevel.checkVictory()
  correct[currentPanel][1]=isCover("C")
  correct[currentPanel][2]=isBlock("S")
  GetDirection()
  local ans=true
  local cnt=0
  for i=1,len(visit[currentPanel]) do
    if map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str=="C" then
      cnt=cnt+1
    end
    if i~=1 and i~=len(visit[currentPanel]) and direction[i]~=direction[i-1] then
      if cnt~=1 then
        ans=false
      end
      if map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str=="C" then
        cnt=1
      else
        cnt=0
      end
    end
  end
  if cnt~=1 then
    ans=false
  end
  correct[currentPanel][3]=ans
end
return newlevel

--[[  for i=1,len(visit[currentPanel]) do
    if i~=1 and i~=len(visit[currentPanel]) and direction[i]~=direction[i-1] and map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str~=" " then
      ans=false
    end
  end]]
