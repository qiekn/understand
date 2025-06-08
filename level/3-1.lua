--Area Contains One Kind

newlevel={}


newlevel.level_str={
  {"C S"},
  {"C S",
   "   ",
   "C S"},
  {" C S",
   "    ",
   "C S "},
  {"C  S",
   "    ",
   "    ",
   "S  C"},
  {"C....",
   ".....",
   "..S..",
   ".....",
   "....C"},
  {"S  S  S",
   "       ",
   "C  S  C"},
  {"C.S..",
   ".....",
   ".....",
   "..S.C"},
  {".......",
   ".C.S.C.",
   ".......",
   ".S...S.",
   ".......",
   ".C.S.C.",
   "......."}
}

newlevel.correct_num=2

newlevel.hint={
  {x=2,y=1},
}

newlevel.text="Seperate something."

function newlevel.checkVictory()
  FloodFill()
  correct[currentPanel][1]=isBlock("all")
  local ans=true
  for i=1,len(FloodFillShapeCount[currentPanel]) do
    local cnt=0
    for k,v in pairs(FloodFillShapeCount[currentPanel][i]) do
      if k~=" " then
        cnt=cnt+1
      end
    end
    if(cnt~=1)then
      ans=false
    end
  end
  correct[currentPanel][2]=ans
end
return newlevel
