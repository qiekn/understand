-- area is horizontal mirror

newlevel={}

newlevel.level_str={
  {"C S",
   " U "},
  {" SS",
   "CU "},
  {"   ",
   "CUS",
   " U "},
  {"C  ",
   "U  ",
   " U ",
   "S  "},
   {"   ",
    " C ",
    " U ",
    " S ",
    "   "},
   {"  C  ",
    "     ",
    "     ",
    " U U ",
    "     ",
    "     ",
    "  S  "},
  {"   C   ",
   "       ",
   "  U U  ",
   "       ",
   "   S   "}
}

newlevel.correct_num=5

function newlevel.checkVictory()
  correct[currentPanel][1]=isStart("C")
  correct[currentPanel][2]=isEnd("S")
  correct[currentPanel][3]=isBlock("U")
  FloodFill()
  correct[currentPanel][4]=len(FloodFillRes[currentPanel])==1
  local ans=true
  for i=1,len(FloodFillRes[currentPanel])do
    maxX,minX,maxY,minY=AreaMaxMin(FloodFillRes[currentPanel][i])
    ans=ans and AreaMirror(FloodFillRes[currentPanel][i],FloodFillRes[currentPanel][i],maxX+minX,0,"horizontal")
  end
  correct[currentPanel][5]=ans
end
newlevel.hint={
  {x=1,y=1},
  {x=3,y=1}
}
return newlevel
