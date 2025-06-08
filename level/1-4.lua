-- circle is start, square is end, triangle is cover

newlevel={}

newlevel.level_str={
  {"CUS",
   " D "},
  {"CDS",
   " U "},
  {"C D",
   "   ",
   "U S"},
  {" C ",
   "UUU",
   " S "},
  {"S D  ",
   "UUUU ",
   "DD DD",
   " UUUU",
   "  D C"},
  {"CUUU",
   "UUUU",
   "UUUU",
   "SUUC"}
}
newlevel.correct_num=3

function newlevel.checkVictory()
  correct[currentPanel][1]=isStart("C")
  correct[currentPanel][2]=isEnd("S")
  correct[currentPanel][3]=isCover("U")
end

newlevel.hint={
  {x=1,y=1},
  {x=3,y=1}
}

newlevel.text="Upward triangle and downward triangle count as different shapes."
return newlevel
