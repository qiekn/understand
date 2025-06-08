--one area is double sized of other

newlevel={}

newlevel.level_str={
  {"S  S",
   "    "},
  {"SS  ",
   "SS  "},
  {"   S",
   "    ",
   "    ",
   "S   "},
  {"   S",
   "  S ",
   " S  ",
   "    "},
  {"SSSS",
   "SSSS",
   "    ",
   "  S "},
  {"      ",
   "      ",
   "SSSSSS",
   "SSSSSS"},
  {" S  ",
   "   S",
   "   S",
   " S  "},
  {"S  S   ",
   "       ",
   "       ",
   "S  S   ",
   "       ",
   "       ",
   "      S"},
  {"S  S  ",
   "      ",
   "      ",
   "S  S  ",
   "      ",
   "      "},
  {"S......S",
   "........",
   "........",
   ".S....S.",
   "........"}
}

newlevel.correct_num=3

newlevel.hint={
  {x=2,y=1},
  {x=2,y=2},
  {x=1,y=2}
}

function newlevel.checkVictory()
  FloodFill()
  local ans=false
  local mini=1
  for i=1,len(FloodFillRes[currentPanel]) do
    for j=1,len(FloodFillRes[currentPanel]) do
      local doublearea=BoostArea(FloodFillRes[currentPanel][j],2)
      maxX,minX,maxY,minY=AreaMaxMin(doublearea)
      maxX2,minX2,maxY2,minY2=AreaMaxMin(FloodFillRes[currentPanel][i])
      if AreaMirror(doublearea,FloodFillRes[currentPanel][i],"same")then
        ans=true
      end
    end
  end
  correct[currentPanel][1]=isBlock("all")
  correct[currentPanel][2]=len(FloodFillRes[currentPanel])==2
  correct[currentPanel][3]=ans
end
return newlevel
