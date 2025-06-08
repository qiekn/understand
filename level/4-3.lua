--each area is L shaped

newlevel={}

newlevel.level_str={
  {" C",
   "  "},
  {"  C",
   "   "},
  {"   ",
   " C "},
  {"C  ",
   "   ",
   "   "},
  {".....",
   ".....",
   "..C..",
   ".....",
   "....."},
  {".....",
   ".C...",
   ".....",
   "...C.",
   "....."},
  {"C..",
   "...",
   "...",
   "...",
   "C.."},
  {"C.....C",
   ".......",
   ".......",
   ".......",
   ".......",
   ".......",
   "C.....C"},
}

newlevel.correct_num=3

newlevel.hint={
  {x=1,y=1}
}

function newlevel.checkVictory()
  FloodFill()
  local ans=true
  local ans2=true
  for i=1,len(FloodFillRes[currentPanel]) do
    if isLShape(FloodFillRes[currentPanel][i],true)=="none" then
      ans=false
    end
    if FloodFillShapeCount[currentPanel][i]["C"]~=1 then
      ans2=false
    end
  end
  correct[currentPanel][1]=isBlock("C")
  correct[currentPanel][2]=ans2
  correct[currentPanel][3]=ans
end
return newlevel
