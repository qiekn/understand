newlevel={}

--Area Contains Two Shapes

newlevel.level_str={
  {"SCS",
   "   ",
   "SCS"},
  {"     ",
   "C  S ",
   " S  C",
   "     "},
  {"       ",
   " S S S ",
   "C     C",
   " S S S ",
   "       "},
   {"     ",
    "CCCCC",
    "     "},
  {"C C",
   " S "},
   {"C...C",
    ".S...",
    "..S..",
    "...S.",
    "C...C"},
  {"       ",
   "  C C  ",
   " CSCSC ",
   "  CSC  ",
   "   C   ",
   "       "}
}

newlevel.correct_num=4

newlevel.hint={
  {x=2,y=1},
  {x=2,y=3}
}

newlevel.text="Sometimes, shape doesn't matter."

function newlevel.checkVictory()
  FloodFill()
  correct[currentPanel][1]=isStart("C")
  correct[currentPanel][2]=isEnd("C")
  correct[currentPanel][3]=isBlock("S")
  local ans=true
  for i=1,len(FloodFillShapeCount[currentPanel]) do
    local cnt=0
    for k,v in pairs(FloodFillShapeCount[currentPanel][i]) do
      if k~=" "  then
        cnt=cnt+v
      end
    end
    if cnt~=2 then
      ans=false
    end
  end
  correct[currentPanel][4]=ans
end
return newlevel
