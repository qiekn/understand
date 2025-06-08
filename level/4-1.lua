--each area is x*x

newlevel={}

newlevel.level_str={
  {"CUS",
   "   "},
  {"C  ",
   " U ",
   "  S"},
  {"C   ",
   " U  ",
   "    ",
   "   S"},
  {"C   ",
   " U  ",
   "    ",
   "S   "},
  {"C  U",
   "    ",
   "    ",
   "U  S"},
  {"C   ",
   "  U ",
   " U  ",
   "   S"},
  {"C    ",
   "   U ",
   "     ",
   " U   ",
   "    S"},
  {"C    ",
   " U   ",
   "     ",
   "   U ",
   "    S"},
--  {"   C ",
--   " U   ",
--   "  U  ",
--   "S  U ",
--   "     "}
}

newlevel.correct_num=4

newlevel.hint={
  {x=1,y=1},
  {x=1,y=2},
  {x=3,y=2},
  {x=3,y=1}
}

function newlevel.checkVictory()
  FloodFill()
  local ans=true
  local ans2=isBlock("U")
  for i=1,len(FloodFillRes[currentPanel]) do
    x,y=IsRectangle(FloodFillRes[currentPanel][i])
    if not(x==y) then
      ans=false
    end
    if(FloodFillShapeCount[currentPanel][i]["U"]~=1)then
      ans2=false
    end
  end
  correct[currentPanel][1]=isStart("C")
  correct[currentPanel][2]=isEnd("S")
  correct[currentPanel][3]=ans2
  correct[currentPanel][4]=ans
end
return newlevel
