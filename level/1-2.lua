-- square is start, circle is end

newlevel={}

newlevel.level_str={
  {"C S"},
  {"C   C",
   "     ",
   "  S  ",
   "     ",
   "C   C"},
   {"CU   ",
    " U U ",
    "   US"},
  {"C U U S"}
}
newlevel.correct_num=2

function newlevel.checkVictory()
  correct[currentPanel][1]=isStart("S")
  correct[currentPanel][2]=isEnd("C")
end

newlevel.hint={
  {x=3,y=1},
  {x=1,y=1}
}

newlevel.text="Each level has a different rule set."

newlevel.time=-10

return newlevel
