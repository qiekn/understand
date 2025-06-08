-- length is sum of digits

newlevel={}

newlevel.level_str={
  {"..."},
  {"...",
   "..."},
  {"....",
   "....",
   "...."},
  {"..",
   ".."},
  {"...",
   "...",
   "..."},
  {"....",
   "...."},
  {"......",
   "......",
   "......",
   "......"},
  {"......",
   "......",
   "......"},
  {"........",
   "........",
   "........",
   "........"},
  {".........",
   ".........",
   ".........",
   "........."},
  {"........",
   "........",
   "........",
   "........",
   "........",
   "........"},
}

newlevel.correct_num=1

newlevel.hint={
  {x=1,y=1},
  {x=3,y=1},
}

function newlevel.checkVictory()
  local x1=math.modf(mapW[currentPanel]*mapH[currentPanel]/10)
  local x2=mapW[currentPanel]*mapH[currentPanel]%10
  correct[currentPanel][1]=(x1+x2)==len(visit[currentPanel])
end
return newlevel
