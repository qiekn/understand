-- circle is start, square is end, triangle is block

newlevel={}

newlevel.level_str={
  {"CUS",
   " D "},
  {"CDS",
   " U "},
  {"C D",
   "   ",
   "U S"},
  {"S D  ",
   "UUUU ",
   "DD DD",
   " UUUU",
   "  D C"},
  {"CUUUUU  C",
   " UUUUUDUU",
   "   UUU   ",
   " DUUUUUDD",
   "DU     DU",
   "U  UUUUUU",
   "UDUUUU   ",
   "U     UU ",
   "UUUUU   S",
  }
}
newlevel.correct_num=3

function newlevel.checkVictory()
  correct[currentPanel][1]=isStart("C")
  correct[currentPanel][2]=isEnd("S")
  correct[currentPanel][3]=isBlock("U")
end

newlevel.hint={
  {x=1,y=1},
  {x=1,y=2},
  {x=3,y=2},
  {x=3,y=1},
}

newlevel.text="Some symbol has nothing to do with the rules."

return newlevel
