-- two area is reverse mirror

newlevel={}

newlevel.level_str={
  {"CS ",
   " SC"},
  {"C ",
   "SS",
   " C"},
  {"C  C",
   " S  ",
   "  S ",
   "C  C"},
  {" C  ",
   "CSSC",
   "  C "},
  {"....S",
   "C..C.",
   ".....",
   "...S.",
   "S...."},
  {"  C  ",
   "     ",
   "C   C",
   "     ",
   "  C  "},
  {"C S",
   "   ",
   "C S"},
  {".....",
   ".C...",
   "...C.",
   "C....",
   "..C.."},
  {"CS..",
   "....",
   "....",
   "....",
   "CS.."},
  {"     ",
   "     ",
   "C C C",
   "     ",
   "     "}
}

newlevel.correct_num=4

function newlevel.checkVictory()
  correct[currentPanel][1]=isCover("S")
  correct[currentPanel][2]=isBlock("C")
  FloodFill()
  local ans2=false
  for i=1,len(FloodFillRes[currentPanel])do
    maxX,minX,maxY,minY=AreaMaxMin(FloodFillRes[currentPanel][i])
    for j=i+1,len(FloodFillRes[currentPanel])do
      maxX2,minX2,maxY2,minY2=AreaMaxMin(FloodFillRes[currentPanel][j])
      ans2=ans2 or AreaMirror(FloodFillRes[currentPanel][i],FloodFillRes[currentPanel][j],maxX+minX2,maxY+minY2,"reverse")
    end
  end
  correct[currentPanel][3]=len(FloodFillRes[currentPanel])==2
  correct[currentPanel][4]=ans2
end

newlevel.hint={
  {x=2,y=1},
  {x=2,y=2}
}
return newlevel
