-- length is lcm

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
  for i=1,1000 do
    if i%mapW[currentPanel]==0 and i%mapH[currentPanel]==0 then
      correct[currentPanel][1]=len(visit[currentPanel])==i
      return
    end
  end
end
return newlevel
