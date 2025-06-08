-- vertical mirror

newlevel={}

newlevel.level_str={
  {"C ","U ","S "},
  {"C ","U ","  ","S "},
  {"C U S",
   "     ",
   "U    ",
   "     ",
   "S    "},
  {"C ","U ","  "," U","  ","  ","S "},
  {"CS","  "},
  {"C  ","  S"},
  {"C ",
   "  ",
   " U",
   " S",
   "  "},
  {"  U   ",
   "    U ",
   " CUS  "},
  {"C U S",
   "     ",
   "     ",
   "     ",
   "     "},
  {"   ",
   "S  ",
   " C "},
   {"   ",
    "   ",
    " S ",
    "  C",
    "   "},
  {"   ",
   "   ",
   "S  ",
   "  C",
   "   "},
--   {"     ",
--    "     ",
--    "  U  ",
--    "C U S",
--    "  U  ",
--    "     ",
--    "     "}
}

newlevel.correct_num=4

newlevel.hint={
  {x=1,y=1},
  {x=2,y=1},
  {x=2,y=3},
  {x=1,y=3}
}

function newlevel.checkVictory()
  correct[currentPanel][1]=isStart("C")
  correct[currentPanel][2]=isEnd("S")
  correct[currentPanel][3]=isBlock("U")
  maxX,minX,maxY,minY=AreaMaxMin(visit[currentPanel])
  correct[currentPanel][4]=AreaMirror(visit[currentPanel],visit[currentPanel],0,mapH[currentPanel]+1,"vertical")
end
return newlevel
