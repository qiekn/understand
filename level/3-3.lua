--Area Count is two

newlevel={}


newlevel.level_str={
  {"   ",
   "C S",
   "   "},
  {"C  ",
   "   ",
   "  S"},
  {"C S",
   "   ",
   "   "},
  {" C ",
   "  S",
   "   "},
  {"     ",
   " CSC ",
   "     "},
  {"S   ",
   "  C ",
   " C  ",
   "   S"}
}

newlevel.correct_num=3

function newlevel.checkVictory()
  FloodFill()
  correct[currentPanel][1]=isStart("C")
  correct[currentPanel][2]=isEnd("S")
  correct[currentPanel][3]=(len(FloodFillRes[currentPanel])==2)
end

newlevel.hint={
  {x=1,y=2},
  {x=3,y=2}
}

newlevel.text="New chapter, new topic."
return newlevel
